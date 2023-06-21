package main

import (
	"bytes"
	"encoding/binary"
	"fmt"
	"io/ioutil"
	"time"

	"github.com/maseology/goHydro/grid"
	"github.com/maseology/goHydro/tem"
	"github.com/maseology/mmio"
)

func main() {
	tt := time.Now()

	fmt.Println("loading TEM..")
	fp := "M:/DEM-OWRC23/PDEM/PDEM-South-D2013-OWRC23-60-HC.uhdem" //"E:/Sync/@dev/pages_owrc/interpolants/interpolation/calc/hydroDEM/test/PDEM-South-D2013-OWRC23-60_resmpl-HC.uhdem" //
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
	writeInts(mmio.RemoveExtension(fp)+"-sws10.indx", c32)

	fmt.Printf("%s %v\n", "HydroDEM SWS complete!", time.Since(tt))
}

func writeInts(fp string, i []int32) error {
	buf := new(bytes.Buffer)
	if err := binary.Write(buf, binary.LittleEndian, i); err != nil {
		return fmt.Errorf("writeInts failed: %v", err)
	}
	if err := ioutil.WriteFile(fp, buf.Bytes(), 0644); err != nil { // see: https://en.wikipedia.org/wiki/File_system_permissions
		return fmt.Errorf("writeInts failed: %v", err)
	}
	return nil
}
