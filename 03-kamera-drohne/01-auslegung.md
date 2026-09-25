# Auslegung: Rahmen, Propeller, Flugzeit

*Wie aus einer einzigen Entscheidung — der Rahmengröße — fast alles andere folgt.*

## Der Ausgangspunkt: die Fräse

Der Rahmen soll selbst hergestellt werden, auf der vorhandenen CNC-Fräse **1310**. Deren
Arbeitsbereich ist etwa **13 × 10 cm**. Für ein Werkstück mit Einspannung bleibt eine
Platte von rund **9 × 9 cm**.

Das klingt nach einer Nebensache. Tatsächlich legt diese Zahl die Propellergröße fest, die
Propellergröße legt die Motoren fest, die Motoren legen den Akku fest — und der Akku
bestimmt die Flugzeit. Eine schöne Kette für die schriftliche Arbeit.

## Warum keine 3-Zoll-Propeller passen

Jeder Motor braucht einen Motorträger: das Lochbild misst 9 × 9 mm, plus Rand ergibt das
ein Feld von etwa 15 × 15 mm. Die Motorachse liegt damit mindestens **7,5 mm von der
Plattenkante** entfernt.

Auf einer 90 × 90-mm-Platte sitzen die vier Motorachsen dann auf einem Quadrat von
75 × 75 mm. Zwei benachbarte Propeller haben also 75 mm Achsabstand — und ein 3-Zoll-
Propeller ist **76,2 mm im Durchmesser**. Zwei davon nebeneinander bräuchten 76,2 mm
Abstand, um sich gerade eben nicht zu berühren.

| Motorachse vom Rand | Achsabstand der Nachbarn | Radstand | Spalt bei 2,5" | bei 2,8" | bei 3,0" |
|---|---|---|---|---|---|
| 7,0 mm | 76,0 mm | 107,5 mm | +12,5 mm | +5,0 mm | **−0,2 mm** |
| 7,5 mm | 75,0 mm | 106,1 mm | +11,5 mm | +4,0 mm | **−1,2 mm** |
| 8,0 mm | 74,0 mm | 104,7 mm | +10,5 mm | +3,0 mm | **−2,2 mm** |

Ein negativer Spalt heißt: **die Propellerkreise schneiden einander.** Das geht nicht — die
Blätter würden sich zerschlagen.

Machbar sind **2,5 Zoll** (63,5 mm, komfortable 11,5 mm Spalt) oder **2,8 Zoll** (71 mm,
4 mm Spalt). 4 mm sind eng, aber mehr, als viele gekaufte Rahmen dieser Klasse bieten.
Der Radstand liegt in beiden Fällen bei etwa 106 mm.

**Entschieden: 2,8 Zoll.** Der größere Propeller ist bei gleichem Schub sparsamer, und
darum geht es bei einem Ausdauergerät.

### Der Ausweg, den wir nicht nehmen

Echte 3-Zöller wären möglich, wenn man die **Arme getrennt fräst** und an eine
9 × 9-Mittelplatte schraubt — der Fräsbereich begrenzt ja das Einzelteil, nicht die fertige
Baugruppe. Dagegen spricht: Schraubverbindungen kämen genau an die Stelle, die in allen
veröffentlichten Bruchtests **zuerst versagt** — den Übergang Arm zu Rumpf. Der Gewinn
wären etwa 60 Sekunden Flugzeit. Für Version 1 nicht empfohlen.

## Propeller: zwei oder drei Blätter?

**Was die Physik sagt:** Weniger Blätter sind sparsamer, weil jedes Blatt in der
Verwirbelung des vorhergehenden arbeitet. Mehr Blätter geben bei begrenztem Durchmesser
mehr Schub und laufen ruhiger, ziehen dafür mehr Strom. Für Ausdauer spricht also
Zweiblatt.

**Was die Messdaten sagen:** Dasselbe. Alle drei Ausdauer-Referenzbauten der Messseite
lithiumionfpv.com fliegen einen Zweiblatt-Propeller (Gemfan Hurricane 3018).

**Was der Markt sagt:** Etwas anderes. In 2,8 Zoll gibt es praktisch nur Dreiblatt. Ein
2,8"-Zweiblatt war nicht auffindbar; Zweiblätter gibt es reichlich in 3 Zoll — und 3 Zoll
passt nicht.

**Warum es kaum eine Rolle spielt:** Durchgerechnet auf unser Gerät bei 160 g Abflug-
gewicht ist der Unterschied **etwa eine Minute**:

| Variante | Abfluggewicht | geschätzte Flugzeit |
|---|---|---|
| 2,8" **Dreiblatt** (gewählt) | 160 g | **11–19 min** |
| 2,8" Zweiblatt (nicht lieferbar) | 160 g | 12–20 min |
| 2,5" Zweiblatt | 160 g | 11–18 min |
| 3" Zweiblatt mit angeschraubten Armen | 165 g | 12–20 min |

**Entschieden: HQProp T2.8×1.6×3 (2816), 1,5-mm-Bohrung, Dreiblatt.** Die Steigung 1,6"
auf 2,8" ergibt ein Steigungsverhältnis von 0,57 — fast dasselbe wie beim bewährten 3018
(0,60), passt also zum ruhigen Reiseprofil.

Ein Nebeneffekt hilft uns hier sogar: **Dreiblätter laufen vibrationsärmer.** Unser Kreisel
hängt am I2C-Bus und hat damit eine begrenzte Abtastrate — je ruhiger der Rahmen, desto
besser für die Flugregelung.

> **Wichtig:** Propeller werden in **beiden Drehrichtungen** gebraucht (CW und CCW).
> Genau daran ist der Holz-Bausatz aus Schritt 1 gescheitert — er drehte sich ständig um
> die Hochachse, weil die Drehmomente sich nicht aufhoben. Mindestens drei Sätze Ersatz
> mitbestellen.

## Der Rahmen

- **Material: 2,5 mm 3K-Kohlefaser**, einteilig, 90 × 90 mm, Zielgewicht 12 g.
- Motorachsen 7,5 mm von den Kanten, **Lochbild 9 × 9 mm M2** — dieses Lochbild haben alle
  in Frage kommenden Motoren, die Bohrungen sind also unabhängig von der endgültigen
  Motorwahl.
- **Großzügige Ausrundungen** am Übergang Arm zu Rumpf, keine scharfen Innenecken. Dort
  brechen alle getesteten Rahmen zuerst.
- Die Akkuzellen liegen oben mittig, im Halter mit Kupferkontakten (gemessen besser als
  gekaufte Messingkontakte).

> **Warum 2,5 mm und nicht 2 mm:** Ein einteiliger 3-Zoll-Carbonrahmen riss in den
> ausgewerteten Tests bei 2 mm Materialstärke **ohne echten Absturz** und wurde daraufhin
> auf 2,5 mm erhöht. Bei nur 2 mm vorhandener Platte müssten die Arme gedoppelt werden.

> **Achtung beim Fräsen:** Kohlefaserstaub ist gesundheitsschädlich **und elektrisch
> leitfähig**. FFP2/FFP3-Maske, Absaugung oder nass fräsen, und die Elektronik der Fräse
> abdecken. Einschneider aus Hartmetall oder mit Diamantverzahnung, 1–2 mm, hohe Drehzahl,
> mehrere flache Zustellungen. M2-Löcher (2,1 mm) lassen sich mit einem 1,5-mm-Fräser
> spiralförmig ausfräsen.

> **Und noch eins:** Kohlefaser leitet Strom. Alles Blanke auf dem Rahmen mit flüssigem
> Isolierband isolieren, sonst gibt es Kurzschlüsse.

### Prüfung nach dem Fräsen

Den halben Rahmen einspannen, **1,13 kg am Motorträger** anhängen und die Auslenkung
messen. **Zielwert: unter 6 mm.** Das ist ein schöner, überprüfbarer Versuch für die
schriftliche Arbeit — mit Messwert und Vergleich zu veröffentlichten Rahmen.

## Erwartete Flugzeit

Die Schätzung entsteht durch Hochrechnung von gemessenen Referenzbauten über die
physikalische Beziehung: **Schwebeleistung ∝ Masse^1,5 / √Propellerfläche.** Schwerer
kostet also überproportional, größere Propeller helfen.

| Aufbau | Abfluggewicht | geschätzte Flugzeit |
|---|---|---|
| Idealfall 1S-AIO (fertige Elektronik, 1 Zelle) | 88 g | 15–24 min |
| **Unser Aufbau: 2S, eigene Platine, 2 × 18650** | **~160 g** | **11–19 min** |
| dito mit 21700-Zellen | ~207 g | 13–21 min |

Zwei Dinge sind daran bemerkenswert und gehören in die Arbeit:

**Größere Zellen bringen fast nichts.** Die 21700 speichert mehr Energie, wiegt aber auch
mehr — und das Mehrgewicht frisst den Gewinn fast auf. Ein Gegenbeispiel zur Intuition
„größerer Akku = längerer Flug".

**Der wirkliche Hebel ist das Trockengewicht.** Jedes Gramm, das nicht fliegen muss,
verlängert den Flug überproportional. Deshalb: leichte Module statt großer Platinen, kurze
Kabel, sparsamer Zellhalter.

> Das sind **Abschätzungen aus fremden Messwerten, keine eigenen Messungen** — als
> Zielkorridor brauchbar, nicht als Zusage. Die tatsächliche Flugzeit selbst zu messen und
> mit dieser Vorhersage zu vergleichen, wäre ein gutes Schlusskapitel.
