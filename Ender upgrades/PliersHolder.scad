use <VslotCover_Cust.scad>;

dlzkaKolajnic = 135;
rozchodKolajnic = 20;

sirkaKlieste = 55;

$fn = 64;


module boxKlieste() {
    hrubkaSteny = 1.6;
    vyskaBoxKlieste = 13.5;
    vonkajsiaVyskaBoxKlieste = vyskaBoxKlieste + 2 * hrubkaSteny;
    translate([-8,0,-vyskaBoxKlieste-4.5])
    rotate([270,270,0])
        linear_extrude(dlzkaKolajnic - 20) difference() {
            offset(2 * hrubkaSteny) square([vyskaBoxKlieste - 2 * hrubkaSteny, sirkaKlieste - 2 * hrubkaSteny]);
            offset(hrubkaSteny) square([vyskaBoxKlieste - 2 * hrubkaSteny, sirkaKlieste - 2 * hrubkaSteny]);
        }

    //    translate([-5,20,-vonkajsiaVyskaBoxKlieste-4])
    //        difference() {
    //            cube([sirkaKlieste + 2 * hrubkaSteny, dlzkaKolajnic - 20, vonkajsiaVyskaBoxKlieste]);
    //            translate([hrubkaSteny, 0, hrubkaSteny]) cube([sirkaKlieste, dlzkaKolajnic - 20, vyskaBoxKlieste]);
    //        }
}

module test1() {
    vslotCover(dlzkaKolajnic-40, rozchodKolajnic);
    translate([20, 0, 0]) vslotCover(dlzkaKolajnic-40, 4);

    translate([0, 0, 0]) boxKlieste();
}

test1();

//!boxKlieste();
