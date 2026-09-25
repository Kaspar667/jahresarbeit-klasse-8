# Schritt 3 — Eigenbau-Drohne (Abschlusswerk)

Das praktische Hauptwerk der Jahresarbeit: eine Drohne, die **nicht gekauft, sondern
entworfen** wird. Rahmen selbst gefräst, Trägerplatine selbst entworfen und gefräst,
Flugsoftware selbst konfiguriert.

Im Gegensatz zu Schritt 1 (fertiger Bausatz) und Schritt 2 (fertiges Board, eigene
Firmware) wird hier **jedes Teil bewusst ausgewählt und die Auswahl begründet**. Genau
diese Begründungen sind der Stoff der schriftlichen Arbeit — nicht die Bauanleitung.

## Der Stand in einem Absatz

Geplant ist ein **Quadrocopter mit 9 × 9 cm Kohlefaserrahmen**, ausgelegt nicht auf Schub,
sondern auf **Ausdauer**: Ziel sind 15–30 Minuten Flugzeit, realistisch geschätzt 11–19.
Angetrieben von vier bürstenlosen 1204-Motoren an einem gekauften 4-in-1-Regler, gesteuert
von einem **Seeed XIAO ESP32-S3** (demselben Mikrocontroller wie in Schritt 2) mit der
offenen Flugsoftware **ESP-FC**. Dazwischen sitzt eine **selbst entworfene Trägerplatine**,
die auf der CNC-Fräse 1310 hergestellt wird. Motoren und Regler sind bestellt
(23.09.2026), die Steuerungsseite noch nicht.

## Die Kapitel

| Datei | Inhalt |
|---|---|
| [`01-auslegung.md`](01-auslegung.md) | Rahmen, Propellergröße, Flugzeit — warum 9 × 9 cm alles andere festlegt |
| [`02-antrieb.md`](02-antrieb.md) | Motoren, Regler, Akku — und warum es 2S werden musste |
| [`03-elektronik.md`](03-elektronik.md) | XIAO ESP32-S3, ESP-FC, Pinbelegung, Fernsteuerung |
| [`04-traegerplatine.md`](04-traegerplatine.md) | Die eigene Platine: Entwurf, Schaltplan, Bauteile |
| [`05-bestellliste.md`](05-bestellliste.md) | Was bestellt ist, was noch fehlt |

## Die sechs Entscheidungen, um die es geht

Wer die Arbeit schreibt, braucht vor allem diese sechs — jede ist eine Abwägung, keine
Geschmacksfrage.

**1. Ausdauer statt Schub.** Man kann dieselbe Baugröße auf Beschleunigung auslegen
(Renn-Drohne, 2 Minuten Flugzeit) oder auf lange Flugzeit. Entschieden: Ausdauer. Das legt
Akkutyp (Lithium-Ionen-Rundzellen statt LiPo), Propellersteigung und Motorwahl fest.

**2. 9 × 9 cm — und damit keine 3-Zoll-Propeller.** Der Fräsbereich der 1310 gibt die
Rahmengröße vor. Daraus folgt durch reine Geometrie, dass 3-Zoll-Propeller sich
überschneiden würden. Es werden 2,8 Zoll. → [`01-auslegung.md`](01-auslegung.md)

**3. Eigene Steuerplatine statt fertiger Flugsteuerung.** Nicht aus Ehrgeiz: ein Kreisel,
der an fliegenden Drähten hängt, misst die Schwingung der Drähte mit und lässt sich nicht
abstimmen. → [`04-traegerplatine.md`](04-traegerplatine.md)

**4. Zwei Akkuzellen (2S) statt einer.** Folgt zwangsläufig aus Entscheidung 3: getrennte
Regler, wie sie ein eigenes Board braucht, gibt es im Handel erst ab zwei Zellen. Kostet
etwa 15 % Flugzeit — das ist der Preis für den eigenen Entwurf.
→ [`02-antrieb.md`](02-antrieb.md)

**5. Kreisel über I2C, nicht SPI.** Der XIAO hat nur elf nutzbare Anschlüsse. SPI wäre
schneller, würde aber vier davon verbrauchen — dann bliebe kein Platz mehr für Barometer
und Summer. → [`03-elektronik.md`](03-elektronik.md)

**6. Der Ausbau in drei Stufen.** Einen bürstenlosen Regler von Grund auf zu bauen ist ein
eigenes Projekt. Deshalb gestaffelt, und **jede Stufe fliegt für sich**:

- **Stufe 1 — eigene Trägerplatine, gekaufter Regler.** ← *hier stehen wir*
- **Stufe 2 — eigener Regler** mit der offenen AM32-Firmware.
- **Stufe 3 — Gestensteuerung** über Raspberry Pi mit Kamera.

## Offene Frage: Wo ist die Kamera?

Der Projekttitel heißt „Kamera-Drohne", die aktuelle Auslegung enthält aber **keine
Kamera** — eine FPV-Kamera samt Videosender wiegt rund 15 g, und 15 g kosten bei 160 g
Abfluggewicht spürbar Flugzeit. Das ist eine bewusst offene Entscheidung, keine
Vergesslichkeit. Drei Möglichkeiten:

1. **Ohne Kamera fliegen, Kamera später nachrüsten.** Flugzeit bleibt maximal.
2. **Leichte Aufnahmekamera mitnehmen** (z.B. eine „Naked GoPro" oder RunCam-Modul) —
   nimmt auf, überträgt aber kein Live-Bild. Kein zweites Funksystem nötig.
3. **Echte FPV-Ausrüstung** mit Live-Bild und Videobrille. Am teuersten, am schwersten,
   aber das, was man sich unter einer Kamera-Drohne vorstellt.

Für Stufe 3 (Gestensteuerung) kommt die Kamera ohnehin ins Spiel — dort allerdings am
**Boden**, auf einem Raspberry Pi, der Kaspars Handbewegungen erkennt und in Steuersignale
übersetzt. Auch das wäre ein legitimer Weg, den Projekttitel einzulösen.

**Zu klären, bevor der Rahmen gefräst wird** — eine Kamera braucht Platz und eine
Halterung.

## Was als Nächstes passiert

1. Dicke der vorhandenen Kohlefaserplatte prüfen (soll 2,5 mm sein).
2. Rahmen in CAD zeichnen: 90 × 90 mm, Motorachsen 7,5 mm von den Kanten.
3. Trägerplatine layouten und auf der 1310 fräsen.
4. Fehlende Teile bestellen — das Kreiselmodul zuerst, ohne das fliegt nichts.
5. Ersten Rahmen fräsen und die Steifigkeit messen (Zielwert unter 6 mm Auslenkung).
