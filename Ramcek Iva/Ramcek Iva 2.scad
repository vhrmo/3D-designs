/*
    Ramik s mackom
 */

use <../Parts/Drziak s trnmi.scad>

$fn = 60;

module ramikSVG() {
    linear_extrude(height = 2.4) {
        translate([- 40, - 60, 0])
            import("../Macko nadacia/Ramik.svg");
    }
}

module ramik() {
    difference() {
        ramikSVG();
        translate([0, 0, 1.6])
            resize([58, 0, 0], auto = [true, true, false])
                ramikSVG();
    }
}

module macko() {
    union() {
        translate([- 40, 32, 1.6]) import("Macko z SVG v5.stl");
        translate([5.2, - 7.4, 1]) sphere(4);
        ramik();
    }
}

//macko();
//union() {
//    translate([75, 5, 3])
//        resize([45, 0, 0], auto = [true, true, false])
//            macko();
//}

holder(width = 80, heightBack = 18, heightFront = 12, depth = 4, opening = 0.6, pins = 5);





