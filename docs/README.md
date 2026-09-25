# Schriftliche Ausarbeitung

Hier entsteht der schriftliche Teil der Jahresarbeit.

Vorschlag für die Gliederung:

1. **Einleitung** — Warum eine Kamera-Drohne? Persönliche Motivation.
2. **Grundlagen** — Wie fliegt eine Drohne? (Auftrieb, 4 Motoren, Gyroskop/IMU, Steuerung)
3. **Schritt 1 — Holz-Bausatz** — Aufbau, was funktioniert hat, was nicht.
4. **Schritt 2 — ESP-FLY** — eigene Firmware, Mikrocontroller (ESP32-S3), Sensor, Flashen.
5. **Schritt 3 — Eigenbau-Drohne** — Planung, Bau, Ergebnis. Das umfangreichste Kapitel;
   Material und Begründungen liegen in [`../03-kamera-drohne/`](../03-kamera-drohne/):
   - Auslegung: warum die Rahmengröße alles andere festlegt
   - Antrieb: bürstenlos statt Bürsten, und warum daraus zwei Akkuzellen folgen
   - Elektronik: derselbe Mikrocontroller wie in Schritt 2, andere Software
   - Die eigene Trägerplatine: Entwurf, Schaltplan, Fertigung auf der Fräse
6. **Reflexion** — Was habe ich gelernt? Was würde ich anders machen?
7. **Quellen**

Bilder und Videos gehören in einen Unterordner `docs/bilder/`.

## Hinweis zu Schritt 3

Die Kapiteldateien in `03-kamera-drohne/` sind bewusst so geschrieben, dass jede
Entscheidung eine **Begründung und eine verworfene Alternative** hat. Genau das ist der
Stoff, aus dem die schriftliche Arbeit besteht — eine reine Bauanleitung wäre zu wenig.

Besonders ergiebige Stellen:

- **Geometrie:** dass 3-Zoll-Propeller auf 9 × 9 cm nicht passen, lässt sich vorrechnen.
- **Folgekosten einer Entscheidung:** die eigene Platine erzwingt 2S und kostet dadurch
  ~15 % Flugzeit.
- **Datenblatt gegen Messung:** eine Akkuzelle mit 52 A Angabe schafft real 25 A.
- **Eigene Messung:** Rahmensteifigkeit (1,13 kg am Motorträger, Zielwert unter 6 mm) und
  die tatsächliche Flugzeit im Vergleich zur Vorhersage von 11–19 min.
- **Lehre aus Schritt 1:** warum ein Quadrocopter überhaupt zwei Drehrichtungen braucht —
  der Holz-Bausatz drehte sich ständig um die Hochachse, weil sich die Drehmomente nicht
  aufhoben.
