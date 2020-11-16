
/*
    Ramik s mackom
 */


hrubkaVrstvy = 0.20;

sirka = 80;
vyska = 18;

hrubkaZadnaStena = 6*hrubkaVrstvy;
hrubkaVyrezPreObrazok = 3*hrubkaVrstvy;
hrubkaPrednaStena = 6*hrubkaVrstvy;
hrubka = hrubkaZadnaStena+hrubkaVyrezPreObrazok+hrubkaPrednaStena;

spodnaHrana = 3;
prekrytieObrazku = 5;

mackoSirka = 40;
mackoVyska = 40;

// pocet trnov na upevnenie obrazku
pocetTrnov = 4;

module macko1() {
    translate([sirka-mackoSirka/4, prekrytieObrazku, hrubka - 3 * hrubkaVrstvy])
        resize([mackoSirka,mackoVyska,0])
            translate([-25,-46,0]) // umiestnenie na stred
                import("/Users/vlado/Downloads/Macko (7).stl");
}

module macko2() {
    translate([sirka-mackoSirka/4, prekrytieObrazku, hrubka - 3 * hrubkaVrstvy])
        resize([mackoSirka,mackoVyska,0])
            translate([-25,-46,0]) // umiestnenie na stred
                    linear_extrude(height = 2) {
                        import("/Users/vlado/Projects/3D-designs/Macko nadacia/Macko.svg");
                    }
}

module macko() {
    translate([sirka-mackoSirka/4, prekrytieObrazku, hrubka - 3 * hrubkaVrstvy])
//        resize([mackoSirka,mackoVyska,0])
            translate([-25,-46,0]) // umiestnenie na stred
                linear_extrude(height = 2) {
                    import("/Users/vlado/Projects/3D-designs/Macko nadacia/Ramik.svg");
                }
    translate([sirka-mackoSirka/4, prekrytieObrazku, hrubka - 3 * hrubkaVrstvy])
//        resize([mackoSirka,mackoVyska,0])
            translate([-25,-46,0]) // umiestnenie na stred
                linear_extrude(height = 3) {
                    import("/Users/vlado/Projects/3D-designs/Macko nadacia/Macko.svg");
                }
}

module baseFrame() {
    difference() {
        cube([sirka, vyska, hrubka]);
        translate([0,prekrytieObrazku+spodnaHrana,hrubkaZadnaStena]) cube([sirka, vyska, hrubka]);
        translate([0,spodnaHrana,hrubkaZadnaStena]) cube([sirka, vyska, hrubkaVyrezPreObrazok]);
    }
}

$fn = 14;

module trne() {
    rozpatie = sirka / pocetTrnov;

    for (i = [0:1:pocetTrnov - 1]) {
        #translate([i * rozpatie + rozpatie / 2, spodnaHrana + 1.5, hrubkaZadnaStena]) rotate([- 90, 0, 0]) cylinder(
        h = 3, d1 = 0.8, d2 = 0.01);
    }
}

module spojky() {
    #translate([sirka-10,prekrytieObrazku ,hrubka-3*hrubkaVrstvy]) cube([3,2,1]);
    #translate([sirka-19,prekrytieObrazku ,hrubka-3*hrubkaVrstvy]) cube([2,2,1]);
}


module drziak() {
    union() {
        difference() {
            baseFrame();
            macko();
        }
        trne();
        spojky();
    }
}

module mackoSVyrezom() {
    difference() {
        macko();
        spojky();
    }
}

module preview() {
    union() {
        baseFrame();
        trne();
        spojky();
        macko1();
    }
}

//!mackoSVyrezom();
//!drziak();
preview();







