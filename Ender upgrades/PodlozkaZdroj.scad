


$fn = 32;

dlzka = 160;
sirka = 38;
posun = (160 - 145) / 2;

difference() {
    hull() {
        cube([dlzka, 1, 1.4]);
        translate([0, sirka, 0]) cube([dlzka, 1, 0.4]);
    }
    translate([posun, 9, 0]) cylinder(h = 10, d = 4);
    translate([145+posun, 9, 0]) cylinder(h = 10, d = 4);
}