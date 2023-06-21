---
title: Hydrologically-corrected digital elevation model 
author: Oak Ridges Moraine Groundwater Program
output: html_document
---

# Processing steps

1. Downloaded [Provincial Digital Elevation Model (PDEM)](https://geohub.lio.gov.on.ca/maps/mnrf::provincial-digital-elevation-model-pdem/about) and downscaled from its 30m resolution to a 60m grid. This puts the final DEM to a 12.8M cells covering 46,000 km².

2. Run script to build the Hydrologically-corrected digital elevation model (HDEM)
    ```
    tt := time.Now()

    var dem grid.Real
    var tdem *tem.TEM
    var err error

    fp := "./PDEM-South-D2013-OWRC23-60.bil"
    fmt.Printf("loading %s..\n", fp)
    if err := dem.ImportBil(fp); err != nil {
        panic(err)
    }
    if dem.GD.Nact != len(dem.A) {
        panic("main: dimension err1")
    }

    fmt.Println("building tem..")
    if tdem, err = tem.NewFromReal(dem); err != nil {
        panic(err)
    }

    tdem.FillDepressions(dem.GD) // order, flat regions

    fmt.Println("saving uhdem..")
    tdem.SaveUHDEM(mmio.RemoveExtension(fp) + "-HC.uhdem")

    fmt.Printf("%s %v\n", "HydroDEM complete!", time.Since(tt))
    ```

1. Build 10km subwatersheds:
    ```
	tt := time.Now()

	fmt.Println("loading TEM..")
	fp := "./PDEM-South-D2013-OWRC23-60-HC.uhdem"
	tem, err := tem.NewTEM(fp)
	if err != nil {
		panic(err)
	}

	fmt.Println("loading GDEF..")
	gd, err := grid.ReadGDEF(mmio.RemoveExtension(fp)+".gdef", false)
	if err != nil {
		panic(err)
	}

	fmt.Println("creating subwatersheds..")
	sws, ns := tem.SubwatershedsBifuricate(gd, 10e6)

	fmt.Printf("saving %d subwatersheds to bil..\n", ns)
	c32 := gd.NullInt32(-9999)
	for c, n := range sws {
		c32[c] = int32(n)
	}
    func writeInts(fp string, i []int32) error {
        buf := new(bytes.Buffer)
        if err := binary.Write(buf, binary.LittleEndian, i); err != nil {
            return fmt.Errorf("writeInts failed: %v", err)
        }
        if err := ioutil.WriteFile(fp, buf.Bytes(), 0644); err != nil {
            return fmt.Errorf("writeInts failed: %v", err)
        }
        return nil
    }
	writeInts(mmio.RemoveExtension(fp)+"-sws10.indx", c32)

	fmt.Printf("%s %v\n", "HydroDEM SWS complete!", time.Since(tt))
    ```

1. Using QGIS converted sws raster to polygons. Manual editing performed to:
    1. remove "farfield" watersheds
    2. clip subwatersheds to lake boundaries
    2. removed small subwatersheds
    1. merge lake subwatersheds
