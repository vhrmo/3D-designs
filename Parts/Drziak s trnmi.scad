/*
    Drziak na fotky s trnmi
 */

$fn = 14;

module holder(width, heightBack, heightFront, depth, opening, pins = 0, sideWall = 0, pinOffset = 2) {
    spodnaHrana = 3;
    hrubkaSteny = (depth - opening) / 2;
    diameter = opening * 1.7;

    union() {
        difference() {
            cube([width, heightBack, depth]);
            translate([0, heightFront, hrubkaSteny]) cube([width, heightBack, depth]);
            translate([sideWall, spodnaHrana, hrubkaSteny]) cube([width - 2 * sideWall, heightBack, opening]);
        }
        // Pins
        step = width / pins;
        for (i = [0:1:pins - 1]) {
            translate([i * step + step / 2, spodnaHrana + pinOffset, hrubkaSteny])
                rotate([- 90, 0, 0])
                    cylinder(h = 4 * diameter, d1 = diameter, d2 = 0.1);
        }

    }
}

// Drziak na skrabku
//holder(width = 42, heightBack = 40, heightFront = 25, depth = 4, opening = 1, pins = 4, sideWall = 1, pinOffset = 12);

// Drziak na fotku
holder(width = 100, heightBack = 18, heightFront = 12, depth = 4, opening = 0.8, pins = 8);






