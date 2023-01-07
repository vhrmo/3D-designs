// Rozchod kolajnic pre dualVslotCover
rozchodKolajnic = 20;

module form(side_extension_width = 0, slot_form = false) {
    /* HIDDEN */
    side_add_w = side_extension_width;

    $fn = 1 * 60;

    top2_w = 1 * 9.6;
    top_w = 1 * 10; // 9.2 -v2> 9.6 -v3> 10
    w1 = 1 * 8.4;
    w2 = 1 * 6;
    w3 = 1 * 7.4; // 8 -v2> 7.4
    bottom_w = 1 * 5.8;

    h1 = 1 * 4; // 3.8 -v4> 4.0
    h2 = 1 * 2;
    h3 = 1 * 1.2;
    h_top_cover = 1 * 0.5;

    wall_thick = 1 * 0.8; //
    tb_thick = 1 * 0; // top-bottom thickness 0.8 -v3> 0.4 -v4> 0

    // MAIN

    difference() {
        polygon(points = [[- bottom_w / 2, 0],
                [- w3 / 2, h3],
                [- w2 / 2, h2],
                [- w1 / 2, h1],
                [- top2_w / 2, h1],
                [- top_w / 2, h1 + h_top_cover],
                [top_w / 2 + side_add_w, h1 + h_top_cover],
                [top2_w / 2 + side_add_w, h1],
                [w1 / 2, h1],
                [w2 / 2, h2],
                [w3 / 2, h3],
                [bottom_w / 2, 0]]);

        if (!slot_form) polygon(points = [[- bottom_w / 2 + wall_thick, tb_thick],
                [- w3 / 2 + wall_thick, h3],
                [- w2 / 2 + wall_thick, h2],
                [- w1 / 2 + wall_thick, h1],
                [w1 / 2 - wall_thick, h1],
                [w2 / 2 - wall_thick, h2],
                [w3 / 2 - wall_thick, h3],
                [bottom_w / 2 - wall_thick, tb_thick]]);
    }
}


module vslotCover(length, side_extension_width = 0) {
    rotate([- 90, 0, 0])
        linear_extrude(height = length) {
            form(side_extension_width = side_extension_width);
        }
}

module dualVslotCover(dlzka = 135) {
    vslotCover(dlzka, rozchodKolajnic);
    translate([rozchodKolajnic, 0, 0]) vslotCover(dlzka, 0);
    //    translate([0, 0, 0]) boxKlieste();
}

module vslot(length) {
    rotate([- 90, 0, 0])
        linear_extrude(height = length) {
            form(slot_form = true);
        }
}

module vslot_test() {
    difference() {
        translate([- 11, 0, - 4]) cube([22, 10, 6]);
        vslot(10);
    }
}

//dualVslotCover(40);

//vslotCover(50,20);
//translate([20, 0, 0]) vslotCover(10);
vslot_test();

//form(slot_form=true);
