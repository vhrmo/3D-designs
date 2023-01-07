use <../Parts/Vruty.scad>

sirka = 12; // sirka bloku a jednotlivych komponentov
v1 = 3;  // vyska zakladne
v2 = 6;  // vyska klipu pre kabel

$fn=30;

// Blok pre uchytenie kabla
module kabel(priemer, vyska=10) {
    polomer = priemer/2;
    dlzka = priemer+4;
    zoffset = v1+0.5*priemer;
//    vyska = v1+priemer+v2;
    difference() {
        cube([dlzka, sirka, vyska]);
        translate([dlzka/2, 0, zoffset]) rotate([270, 0, 0]) cylinder(d = priemer, h = sirka);
        hull() {
            translate([dlzka/2, 0, zoffset]) rotate([0, 0, 0]) cylinder(d1 = priemer*0.5, d2 = priemer+2, h = vyska-zoffset);
            translate([dlzka/2, sirka, zoffset]) rotate([0, 0, 0]) cylinder(d1 = priemer*0.5, d2 = priemer+2, h = vyska-zoffset);
        }
    }
    if ($children)
        translate([dlzka, 0, 0])
            children();
}

// Blok pre vrut
module vrut(priemer, offset) {
    dlzkaBlokuPreVrut = 12;
    vyskaVrut = v1 + 2;
    difference() {
        cube([dlzkaBlokuPreVrut, sirka, vyskaVrut]);
        translate([dlzkaBlokuPreVrut / 2, sirka / 2, vyskaVrut]) rotate([180, 0, 0]) otvorVrut3_5mm(vyskaVrut);
    }
    if ($children)
        translate([dlzkaBlokuPreVrut, 0, 0])
            children();
}

//!kabel(6);

// Naskladaj komponenty. Kazdy dalsi komponent musi byt child predchadzajuceho - t.j. nedavat bodkociarku.
translate([0,30,0])
kabel(3.1, 8)
vrut()
kabel(6.9, 10);

// 7 3.7  7
!vrut()
kabel(6.8)
kabel(4)
kabel(7)
vrut();


