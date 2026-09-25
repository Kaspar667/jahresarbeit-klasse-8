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

## Entschieden (25.09.2026): Kamera mit Live-Bild

Der Projekttitel heißt „Kamera-Drohne", und die Kamera kommt jetzt auch dran:
**analoges FPV** mit einer Nano-Kamera, einem kleinen 5,8-GHz-Videosender (25 mW) und einer
**Videobrille mit Rekorder**. Damit gibt es ein Live-Bild und gleichzeitig eine Aufnahme.

Die Abwägung war:

1. **Ohne Kamera:** maximale Flugzeit, aber das Thema verfehlt.
2. **Nur Aufnahmekamera:** kein Live-Bild, eine HD-Actioncam wiegt 10 g und mehr.
3. **Analoges FPV** ← *gewählt*: ~8 g zusätzlich, Live-Bild, Aufnahme in der Brille.

**Was es kostet:** ~8 g mehr und etwa 10 % Flugzeit (geschätzt ~10–16 min statt 11–18).
Kamera und Sender hängen am 5-V-Ausgang der Trägerplatine und brauchen **keinen GPIO**,
die Pinbelegung bleibt gleich. Dafür muss der 5-V-Regler stärker werden (≥ 1,5 A statt
500 mA). Einzelheiten in [`05-bestellliste.md`](05-bestellliste.md).

Für Stufe 3 (Gestensteuerung) kommt zusätzlich eine Kamera am **Boden** dazu, auf einem
Raspberry Pi, der Kaspars Handbewegungen erkennt.

## Was als Nächstes passiert

1. Dicke der vorhandenen Kohlefaserplatte prüfen (soll 2,5 mm sein).
2. Rahmen in CAD zeichnen: 90 × 90 mm, Motorachsen 7,5 mm von den Kanten, **mit Kamerahalter vorne**.
3. Trägerplatine layouten und auf der 1310 fräsen.
4. Fehlende Teile nach der [Einkaufsliste](05-bestellliste.md) bestellen, das Kreiselmodul zuerst, ohne das fliegt nichts.
5. Ersten Rahmen fräsen und die Steifigkeit messen (Zielwert unter 6 mm Auslenkung).
