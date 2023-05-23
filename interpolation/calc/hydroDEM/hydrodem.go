package main

import (
	"fmt"

	"github.com/maseology/goHydro/grid"
	"github.com/maseology/mmio"
)

func main() {
	tt := mmio.NewTimer()

	var dem grid.Real
	dem.ImportBil("shp/PDEM-South-D2013-OWRC23.bil")
	fmt.Printf(" %d, %d\n", dem.GD.Nact, len(dem.A))

	tt.Lap("\nHydroDEM complete!")
}
