package main

import (
	"fmt"

	"github.com/maseology/goHydro/grid"
	"github.com/maseology/goHydro/tem"
	"github.com/maseology/mmio"
)

func main() {
	tt := mmio.NewTimer()

	var dem grid.Real
	var tdem *tem.TEM
	var err error

	fp := "test/PDEM-South-D2013-OWRC23-60_resmpl.bil"
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

	// // test output
	// fmt.Println("saving..")
	// z32, g32, a32 := dem.GD.NullFloat32(-9999.), dem.GD.NullFloat32(-9999.), dem.GD.NullFloat32(-9999.)
	// for c, t := range tem.TEC {
	// 	z32[c] = float32(t.Z)
	// 	g32[c] = float32(t.G)
	// 	a32[c] = float32(t.A)
	// }
	// writeFloats("shp/z.bil", z32)
	// writeFloats("shp/g.bil", g32)
	// writeFloats("shp/a.bil", a32)
	// tdem.SaveUHDEM("shp/z_resmpl.uhdem") // uncorrected

	fmt.Println("filling depressions..")
	tdem.FillDepressions(dem.GD)
	// oo := tdem.FillDepressions(dem.GD)
	// o32 := dem.GD.NullFloat32(-9999.)
	// for c, n := range oo {
	// 	o32[c] = float32(n)
	// }
	// writeFloats("shp/o.bil", o32)

	fmt.Println("saving uhdem..")
	dem.GD.SaveAs(mmio.RemoveExtension(fp) + "-HC.gdef")
	tdem.SaveUHDEM(mmio.RemoveExtension(fp) + "-HC.uhdem")

	tt.Lap("\nHydroDEM complete!")
}
