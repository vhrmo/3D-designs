$fn = 30;

module otvorVrut(dlzka, priemer, hlavaPriemer, hlavaVyska, zapustenie=2) {
    union() {
        cylinder(h = dlzka, d = priemer);
        cylinder(h = hlavaVyska, d1 = hlavaPriemer, d2 = priemer);
        translate([0,0,-zapustenie]) cylinder(h = zapustenie, d = hlavaPriemer);
    }
}

module otvorVrut4mm(dlzka = 20, zapustenie=2) {
    otvorVrut(dlzka, priemer = 3.4, hlavaPriemer = 8.5, hlavaVyska = 3.2, zapustenie=zapustenie);
}

module otvorVrut3_5mm(dlzka = 20, zapustenie=2) {
    otvorVrut(dlzka, priemer = 2.9, hlavaPriemer = 7.5, hlavaVyska = 3, zapustenie=zapustenie);
}

module otvorVrut3mm(dlzka = 20, zapustenie=2) {
    otvorVrut(dlzka, priemer = 2.4, hlavaPriemer = 6.4, hlavaVyska = 2.2, zapustenie=zapustenie);
}

module testBlok() {
    difference() {
        translate([-8,-6,0]) cube([40,21,7]);

        translate([0,13,0]) union() {
            otvorVrut4mm();
            translate([12, 0, 0]) otvorVrut3_5mm();
            translate([24, 0, 0]) otvorVrut3mm();

        }

        union() {
            otvorVrut4mm();
            translate([12, 0, 0]) otvorVrut3_5mm();
            translate([24, 0, 0]) otvorVrut3mm();
        }
    }
}

testBlok();
