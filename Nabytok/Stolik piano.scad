use <../Parts/Vruty.scad>

// 70 - výška predná doska
// 69 - výška bočné dosky

// zarazka 52mm na docentrovenie bokov
module zarazka_boky() {
    difference() {
        cube([35, 30, 57]);
        cube([30, 30, 52]);
        translate([15, 15, 57])
            rotate([180, 0, 0]) otvorVrut3mm();
        translate([35, 15, 25])
            rotate([0, - 90, 0]) otvorVrut3mm();
    }
}

module forma_front_nohy() {
    offset = 52;
    otvor1 = offset + 21 + 15;
    otvor2 = offset + 21 + 35;
    vyska_inner = offset + 70;
    vyska_outer = vyska_inner + 5;

    difference() {
        cube([35, 20, vyska_outer]);
        cube([30, 20, vyska_inner]);
        translate([15, 10, vyska_outer])
            rotate([180, 0, 0]) otvorVrut3mm();
        translate([36, 10, vyska_inner - 20])
            rotate([0, - 90, 0]) otvorVrut3mm();
        translate([36, 10, 60])
            rotate([0, - 90, 0]) otvorVrut3mm();
        translate([36, 10, 4])
            rotate([0, - 90, 0]) otvorVrut3mm();

        translate([25, 10, vyska_inner - otvor1]) rotate([0, 90, 0]) cylinder(h = 20, d = 8.5);
        translate([25, 10, vyska_inner - otvor2]) rotate([0, 90, 0]) cylinder(h = 20, d = 8.5);
    }
}


module forma_front_doska() {
    korekciaVyska = 0.2;
    korekciaSirka = 0;
    vyska = 70 + 2 * korekciaVyska;
    sirka = 20 + 2 * korekciaSirka;
    o1 = 21 + 15;
    o2 = 21 + 35;

    difference() {
        cube([24, 30, 80]);
        translate([0, 5 - korekciaSirka, 5 - korekciaVyska]) cube([20, sirka, vyska]);

        translate([31, 15, 52])
            rotate([0, - 90, 0]) otvorVrut3mm();

        translate([10, 15, vyska - o1 - korekciaVyska + 5])
            rotate([0, 90, 0]) cylinder(h = 20, d = 8.5);
        translate([10, 15, vyska - o2 - korekciaVyska + 5]) rotate([0, 90, 0]) cylinder(h = 20, d = 8.5);
    }
}

module dowel() {
    union() {
        translate([0, 0, 0.4]) cylinder(h = 8, d = 8);
        cylinder(h = 8, d = 7.6);
    }

}

// Vpravo 57
// Vlavo 55
module konzola_zadna_doska_vlavo(vyska = 55) {
    difference() {
        union() {
            cube([20, 6.5, vyska + 3]);
            cube([23, 20, 3]);
            translate([20, 0, 0]) cube([3, 20, 20]);
        }
        translate([10, 5, 20]) rotate([90, 0, 0]) otvorVrut3_5mm();
        translate([10, 5, 40]) rotate([90, 0, 0]) otvorVrut3_5mm();
    }
}

module konzola_zadna_doska_vpravo(vyska = 57) {
    mirror([1, 0, 0])
        konzola_zadna_doska_vlavo(vyska = vyska);
}

// hore 15, dole 20, vyska 35
module bocne_podpory(dlzka = 150) {
    difference() {
        hull() {
            cube([10, dlzka, 35]);
            translate([19, 0, 1]) rotate([- 90, 0, 0]) cylinder(r = 1, h = dlzka);
            translate([14, 0, 34]) rotate([- 90, 0, 0]) cylinder(r = 1, h = dlzka);
        }
        translate([4, 30, 17]) rotate([0, - 90, 0]) otvorVrut3_5mm(zapustenie = 20);
        translate([4, dlzka - 30, 17]) rotate([0, - 90, 0]) otvorVrut3_5mm(zapustenie = 20);
        //        translate([7,0,1.5]) rotate([-90,0,0]) cylinder(d=4, h=dlzka);
        //        translate([12,0,1]) rotate([-90,0,0]) cylinder(d=3, h=dlzka);
        //        translate([16,20,0]) cylinder(d=3, h=3);
        //        translate([3,20,0]) cylinder(d=3, h=3);
        //        translate([16,75,0]) cylinder(d=3, h=3);
        //        translate([3,75,0]) cylinder(d=3, h=3);
        //        translate([16,130,0]) cylinder(d=3, h=3);
        //        translate([3,130,0]) cylinder(d=3, h=3);
    }
}

module krytka_kable(priemer=2.8, vyska=2.7, dlzka = 150) {
    zakladna = 1;
    translate([0,0,0]) cube([19, dlzka, zakladna]);


    translate([16, 20, zakladna]) cylinder(d1 = priemer, d2=priemer-0.2, h = vyska);
    translate([3, 20, zakladna]) cylinder(d1 = priemer, d2=priemer-0.2, h = vyska);
    translate([16, 75, zakladna]) cylinder(d1 = priemer, d2=priemer-0.2, h = vyska);
    translate([3, 75, zakladna]) cylinder(d1 = priemer, d2=priemer-0.2, h = vyska);
    translate([16, 130, zakladna]) cylinder(d1 = priemer, d2=priemer-0.2, h = vyska);
    translate([3, 130, zakladna]) cylinder(d1 = priemer, d2=priemer-0.2, h = vyska);

}

module krytka_kable_short(priemer=2.8, vyska=2.8) {
    translate([1,0,0]) cube([18, 10, 0.56]);
    translate([16, 5, 0]) cylinder(d1 = priemer, d2=priemer-0.1, h = vyska);
    translate([3, 5, 0]) cylinder(d1 = priemer, d2=priemer-0.1, h = vyska);
}


$fn = 60;

//zarazka_boky();
//forma_front_nohy();
//forma_front_doska();
//dowel();
//konzola_zadna_doska_vlavo();
//translate([60,0,0]) konzola_zadna_doska_vpravo();
//bocne_podpory();
krytka_kable();
//translate([0,0,0]) krytka_kable_short();
//translate([30,0,0]) krytka_kable_short(priemer=2.9);
//translate([60,0,0]) krytka_kable_short(priemer=3);