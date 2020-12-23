
use <../Parts/Vruty.scad>

// 70 - výška predná doska
// 69 - výška bočné dosky

// zarazka 52mm na docentrovenie bokov
module zarazka_boky() {
    difference() {
        cube([35, 30, 57]);
        cube([30, 30, 52]);
        translate([15,15,57])
            rotate([180,0,0]) otvorVrut3mm();
        translate([35,15,25])
            rotate([0,-90,0]) otvorVrut3mm();
    }
}

module forma_front_nohy() {
    offset = 52;
    otvor1 = offset+21+15;
    otvor2 = offset+21+35;
    vyska_inner = offset + 70;
    vyska_outer = vyska_inner + 5;

    difference() {
        cube([35, 20, vyska_outer]);
        cube([30, 20, vyska_inner]);
        translate([15,10,vyska_outer])
            rotate([180,0,0]) otvorVrut3mm();
        translate([36,10,vyska_inner-20])
            rotate([0,-90,0]) otvorVrut3mm();
        translate([36,10,60])
            rotate([0,-90,0]) otvorVrut3mm();
        translate([36,10,4])
            rotate([0,-90,0]) otvorVrut3mm();

        translate([25,10,vyska_inner-otvor1]) rotate([0,90,0]) cylinder(h = 20, d = 8.5);
        translate([25,10,vyska_inner-otvor2]) rotate([0,90,0]) cylinder(h = 20, d = 8.5);
    }
}


module forma_front_doska() {
    korekciaVyska = 0.2;
    korekciaSirka = 0;
    vyska=70+2*korekciaVyska;
    sirka = 20 + 2*korekciaSirka;
    o1 = 21+15;
    o2 = 21+35;

    difference() {
        cube([24, 30, 80]);
        translate([0,5-korekciaSirka,5-korekciaVyska]) cube([20, sirka, vyska]);

        translate([31,15,52])
            rotate([0,-90,0]) otvorVrut3mm();

        translate([10,15,vyska-o1-korekciaVyska+5])
            rotate([0,90,0]) cylinder(h = 20, d = 8.5);
        translate([10,15,vyska-o2-korekciaVyska+5]) rotate([0,90,0]) cylinder(h = 20, d = 8.5);
    }
}

module dowel() {
    union() {
        translate([0,0,0.4]) cylinder(h = 8, d = 8);
        cylinder(h = 8, d = 7.6);

    }

}

$fn=60;

//zarazka_boky();
//forma_front_nohy();
forma_front_doska();
//dowel();