# Bauplan: Von der Bestellung bis zum ersten Flug

*Stand 25.09.2026. Die Reihenfolge ist Absicht: Erst wird jedes Teil **einzeln** getestet,
dann zusammengebaut. Wenn am Ende etwas nicht geht, weiß man so, dass es nicht an den
Einzelteilen liegt.*

Zu jedem Schritt **Fotos machen und kurz notieren**, was geklappt hat und was nicht. Das
wird später die schriftliche Arbeit.

## Phase A: Während die Teile unterwegs sind (2–3 Wochen)

- [ ] **1. Kohlefaserplatte messen.** Soll 2,5 mm dick sein, Messschieber an mehreren
      Stellen.
- [ ] **2. Rahmen im CAD zeichnen** (z.B. Fusion 360 oder FreeCAD): 90 × 90 mm,
      Motorachsen 7,5 mm vom Rand, Motorlöcher 9 × 9 mm M2, in der Mitte 20 × 20 mm für den
      Regler, runde Übergänge an den Armen, vorne Platz für eine spätere Kamera.
- [ ] **3. Probefräsen in Holz oder MDF.** Billig, ungefährlich, und man sieht, ob Maße und
      Fräsprogramm stimmen, bevor die teure Kohlefaser dran ist. Probeweise einen Motor
      anschrauben, sobald er da ist.
- [ ] **4. Trägerplatine in KiCad zeichnen** nach dem Schaltplan in
      [`04-traegerplatine.md`](04-traegerplatine.md). Den Stecker zum Regler (J2) erst
      festlegen, wenn der Regler da ist, weil die Pad-Beschriftung noch unbekannt ist.
- [ ] **5. Software vorbereiten:** VS Code mit PlatformIO und den Betaflight-Configurator
      installieren, [ESP-FC](https://github.com/rtlopez/esp-fc) herunterladen und einmal
      für den ESP32-S3 bauen.
- [ ] **6. Mit den Eltern die Haftpflichtversicherung klären.**

## Phase B: Teile sind da, jedes einzeln testen

- [ ] **7. Wareneingang prüfen:** Motoren 6500 KV, Regler 15 A, alles vollständig?
- [ ] **8. Fliegen üben im Simulator.** Die Pocket lässt sich per USB als Joystick an den
      Computer anschließen. Mit einem FPV-Simulator (z.B. Liftoff, Uncrashed) üben. Eine
      bürstenlose Drohne reagiert viel schneller als die aus Schritt 1 und 2, und im
      Simulator kostet ein Absturz nichts.
- [ ] **9. Sensor-Test auf dem Steckbrett:** XIAO + MPU-6050 + BMP280 mit Kabeln auf einem
      Steckbrett verbinden, ESP-FC flashen, die Pins einstellen (Befehle in
      [`03-elektronik.md`](03-elektronik.md)). Im Configurator muss sich das 3D-Modell
      mitbewegen, wenn man das Steckbrett kippt. **Das prüft den Schaltplan, bevor die
      Platine gefräst wird.**
- [ ] **10. Empfänger binden:** ELRS-Empfänger dazu, mit der Pocket binden, im Reiter
      *Receiver* prüfen, dass sich alle Balken mit den Knüppeln bewegen.
- [ ] **11. 5-V-Regler testen:** an ein Netzteil oder den Akku, **Ausgang mit dem
      Multimeter messen**. Erst wenn da 5,0 V stehen, darf etwas anderes dran.
- [ ] **12. Motoren am Regler testen:** Motoren an den Regler löten, Kondensator an die
      Akkupads, Akku **über den Smoke-Stopper** anschließen. **Ohne Propeller!** Im Reiter
      *Motors* jeden Motor einzeln langsam drehen lassen: Richtige Reihenfolge? Richtige
      Drehrichtung?

## Phase C: Bauen

- [ ] **13. Rahmen aus Kohlefaser fräsen.** Maske (FFP2/FFP3), Absaugung oder nass fräsen,
      Fräse abdecken. Danach **Biegetest**: halben Rahmen einspannen, 1,13 kg an den
      Motorträger hängen, Auslenkung messen (Ziel unter 6 mm).
- [ ] **14. Platine fräsen und bestücken.** Vor dem Einstecken des XIAO **alle Messpads mit
      dem Multimeter prüfen**: kein Kurzschluss zwischen 5 V und GND, VBAT richtig.
- [ ] **15. Zusammenbau:** Motoren an den Rahmen, Regler und Platine mit Gummitüllen
      (Softmount), Akkuhalter oben, alle blanken Stellen isolieren (Kohlefaser leitet!).
- [ ] **16. Einstellen im Configurator:**
      - Beschleunigungssensor auf ebener Fläche kalibrieren
      - Schalter auf der Pocket belegen: **Scharfschalten (Arm)**, Flugmodus *Angle*
        (selbst ausgleichend), Höhenhaltung
      - Akkuspannung mit dem Multimeter vergleichen und `vbat_scale` anpassen
      - **Failsafe testen:** Pocket ausschalten, die Motoren müssen stoppen. Ohne das nicht
        fliegen!

## Phase D: Fliegen

- [ ] **17. Propeller drauf, richtige Richtung prüfen.** CW-Propeller auf die
      CW-Motoren, CCW auf die CCW-Motoren. Falsch herum hebt die Drohne nicht ab oder
      überschlägt sich sofort.
- [ ] **18. Erster Flug:** draußen, große Wiese, keine Menschen in der Nähe, im Modus
      *Angle*, nur knapp über dem Boden schweben. Jemand dabei, der aufpasst.
- [ ] **19. Abstimmen:** Wenn die Drohne wackelt oder schwingt, PID-Werte anpassen. Die
      Blackbox (Flugschreiber) hilft herauszufinden, woran es liegt.
- [ ] **20. Messen für die Arbeit:** Abfluggewicht wiegen, Flugzeit mit der Stoppuhr messen
      und mit der Vorhersage (11–18 min) vergleichen. Das ist ein gutes Schlusskapitel.

## Danach

- Kamera nachrüsten (Teile in [`05-bestellliste.md`](05-bestellliste.md), „Später: Kamera")
- Regler-Firmware auf Bluejay umflashen
- Stufe 2: eigener Regler, Stufe 3: Gestensteuerung
