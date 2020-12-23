// Konzola s excentricky ulozenym otvorom - jej otocenim je mozne vyrovnat policku do vodovahy.
//   hrubka - hrubka okolo konzoly
//   steps - odkrokovanie pre roznu hrubku konzoly (pre vyrovnanie policky do vodovahy - otocenim konzoly mozem posunut stranu policky vyssie/nizsie)
module konzola(priemer = 10, dlzka = 90, hrubka = 6, steps = 1, ponor = 10) {
    a = priemer + hrubka + hrubka + 2 * steps;
    b = priemer + hrubka + hrubka + 4 * steps;

    posx = hrubka + priemer / 2;
    posy = hrubka + steps + priemer / 2;

    difference() {
        cube([a, b, dlzka]);
        translate([posx, posy, 0]) cylinder(h = dlzka + 10, d = 10);
        translate([posx, posy, 0]) cylinder(h = 8, d = 19.5);
        translate([2, 2, dlzka - ponor]) cube([a - 4, b - 4, ponor + 5]);
    }
}

// korekcia - o kolko zmensit rozmer vnutorneho boxu aby sa dalo zasunut do otvoru
module krytka(priemer = 10, hrubka = 6, steps = 1, korekcia = 0.2) {
    a = priemer + hrubka + hrubka + 2 * steps;
    b = priemer + hrubka + hrubka + 4 * steps;
    union() {
        cube([a, b, 2]);
        difference() {
            translate([2 + korekcia/2, 2 + korekcia/2, 2])
                cube([a - 4 - korekcia, b - 4 - korekcia, 4]);
            translate([3, 3, 2]) cube([a - 6, b - 6, 4]);
        }
    }
}

// Konzoly trčia 6.2 , 6.8, 6.8, 7.8 cm
//konzola(steps = 0.5, hrubka = 7, ponor = 90-78);
translate([0,0,0]) krytka(steps = 0.5, hrubka = 7, korekcia=0.2);
translate([30,0,0]) krytka(steps = 0.5, hrubka = 7, korekcia=0.4);
translate([60,0,0]) krytka(steps = 0.5, hrubka = 7, korekcia=0.6);
