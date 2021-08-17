

* Vygenerovat gcode v Cura a pozriet v akom poradi tlaci vzorky
* V gcode vyhladat ';TYPE:' 
    * Pre kazdy objekt bude poradie zhruba (steny a skin sa budu viackrat opakovat pre kazdy objekt)
        * ;TYPE:WALL-INNER
        * ;TYPE:WALL-OUTER
        * ;TYPE:SKIN
    * Pred kazdy objekt zadat novy z-offset (novu z position)
            
        ```
        G0 Z0.16  ; Set Z offset to -0.04 (0.200 + z offset)
        G0 Z0.19  ; Set Z offset to -0.01 (0.200 + z offset)
        G0 Z0.21  ; Set Z offset to 0.01 (0.200 + z offset)
        G0 Z0.22  ; Set Z offset to 0.02 (0.200 + z offset)
        
        ; kriz v kruhu v strede
        G0 Z0.20  ; Set Z offset to 0.00 (0.200 + z offset)

        G0 Z0.17  ; Set Z offset to -0.03 (0.200 + z offset)
        G0 Z0.18  ; Set Z offset to -0.02 (0.200 + z offset)
        G0 Z0.20  ; Set Z offset to 0.00 (0.200 + z offset)
        G0 Z0.23  ; Set Z offset to 0.03 (0.200 + z offset)

        ```