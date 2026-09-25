# Antrieb: Motoren, Regler, Akku

*Warum aus „eigene Steuerplatine" zwangsläufig „zwei Akkuzellen" folgt.*

## Bürstenlos statt Bürsten — der Unterschied zu Schritt 2

Die ESP-FLY aus Schritt 2 fährt vier **Coreless-Motoren** über je einen MOSFET. Ein MOSFET
ist ein Schalter: Strom an, Strom aus, und über die Einschaltdauer regelt man die Drehzahl.
Das ist einfach, und deshalb sind kleine Spielzeug-Drohnen so gebaut.

Ein **bürstenloser Motor** funktioniert anders. Er hat drei Wicklungen, und ein Regler muss
sie in der richtigen Reihenfolge und zum richtigen Zeitpunkt bestromen — er muss also
wissen, wo der Rotor gerade steht. Dafür braucht es **drei Halbbrücken pro Motor** und eine
Elektronik, die aus der zurückkommenden Spannung (Gegen-EMK) die Rotorlage errechnet.

> **Kernsatz für die Arbeit:** Ein bürstenloser Regler ist kein größerer Schalter. Er ist
> ein anderes Gerät. Wer „Motortreiber" für bürstenlos sagt, meint einen **Regler (ESC)**.

Dieselbe Erkenntnis in der Gegenrichtung: **Die ESP-FLY-Platine aus Schritt 2 lässt sich
nicht weiterverwenden.** Ihre Ausgänge sind Gate-Ansteuerungen für Bürstenmotoren, keine
Reglersignale. Wiederverwendbar sind aus dem Bausatz das **XIAO-ESP32-S3-Modul selbst** und
Kaspars Handy-App — nicht die Platine.

## Warum es 2S werden musste

Ein eigenes Steuerboard braucht einen **getrennten** Regler, den es ansteuern kann. Die
Recherche im Handel ergab einen klaren Befund:

> **Getrennte 4-in-1-Regler gibt es erst ab zwei Zellen (2S).** Alles, was für eine Zelle
> (1S) angeboten wird, ist ein „AIO" — ein Board mit **fest verbauter** Flugsteuerung. Für
> unser eigenes Board unbrauchbar.

Das ist kein Zufall und kein einzelnes Produkt: Bei FPV24, dem größten deutschen Händler,
ist im ganzen Sortiment „FC, ESC, AIO & Stacks" **kein einziger** 4-in-1-Regler unter 6S
und unter 45 A gelistet. Alles Kleine wird heute als AIO verkauft. Lieferbar ist die Klasse
noch bei den chinesischen Versendern (Banggood, AliExpress) mit EU-Versand.

**Die Folge:** zwei Akkuzellen in Reihe statt einer. Zwei 18650 wiegen ~89 g statt ~45 g.
Der 1S-Weg mit fertigem AIO wäre etwa **15 % länger geflogen**. Das ist der Preis für den
eigenen Entwurf, und er ist vertretbar — eine gute Stelle in der Arbeit, um zu zeigen, dass
technische Entscheidungen Folgekosten haben.

**Und ein Hinweis für später:** Wenn in Stufe 2 der eigene Regler kommt, **bei 2S bleiben**.
Ein Wechsel zurück auf 1S würde andere Motoren erfordern, weil die KV-Zahl an der
Zellenzahl hängt (siehe unten). Das ganze Gerät konsequent auf 2S auszulegen ist billiger
und ehrlicher.

## Motoren: 1204 mit 6500 KV

Die **KV-Zahl** gibt an, wie viele Umdrehungen pro Minute ein Motor pro angelegtem Volt
macht. Sie ist deshalb direkt an die Zellenzahl gekoppelt: Was an einer Zelle 11500 KV
braucht, braucht an zwei Zellen etwa die **Hälfte**.

| Motor | KV | Zellen | Gewicht | Bemerkung |
|---|---|---|---|---|
| **HappyModel EX1204** | 6500 | 2–3S | ~6 g | für 3"-Toothpicks gemacht, günstig — **gewählt** |
| T-Motor F1204 | 6500 | 2–3S | ~6 g | bessere Verarbeitung, teurer |
| iFlight XING Nano 1204 | 6500 | 2–3S | 6,5 g | |
| HappyModel EX1202.5 | 6400 | 1–2S | 4,5 g | leichter, aber für 2,8" zu wenig Schub |

Alle haben **9 × 9 mm M2-Lochbild und 1,5-mm-Welle** — das Lochbild im Rahmen ist also von
der endgültigen Motorwahl unabhängig, und die Propeller passen auf jeden davon.

**Warum 1204 und nicht die leichteren 1202.5:** Mit 2,8"-Propellern an 2S ergeben die 1204
etwa **3,5–4:1 Schub-zu-Gewicht** — genug Reserve für Wind, ohne dass die Drohne nervös
wird. Die 1202.5 wären 6 g leichter, lägen aber bei ~2,5:1, und das ist für draußen zu
knapp.

> Ein Wert zwischen 3:1 und 4:1 gilt als gutmütig. Ein Rennquad hat 8:1 — das ist für einen
> ersten Eigenbau eher gefährlich als hilfreich.

## Regler: HAKRC 15A 4-in-1

Ursprünglich geplant war der Flywoo GOKU BS13A. Der ist **überall ausverkauft** und wird
offenbar nicht mehr produziert — ein gutes Beispiel dafür, dass Bauteilverfügbarkeit Teil
der Konstruktion ist. Ersatz:

| | |
|---|---|
| Spannung | 2–4S |
| Dauerstrom | 15 A je Kanal, Spitze 20 A |
| ESC-Chip | **EFM8BB21F16G** — derselbe wie im Flywoo |
| Firmware ab Werk | BLHeli_S BL16.7 |
| Protokolle | DShot150/300/600, Oneshot, Multishot, PWM |
| Lochbild | **20 × 20 mm** |
| Gewicht | 5,2 g |
| Besonderheit | eingebauter Strommesser, 4-lagige Platine, 3 oz Kupfer |
| Preis | ~20,60 € inkl. EU-Mehrwertsteuer |

**Warum genau der:** 15 A sind für unsere ~9 A im Schwebeflug richtig dimensioniert (der
25-A-Bruder wäre nur schwerer). 2–4S deckt unsere 2S ab. Und der Chip ist derselbe wie beim
ursprünglich geplanten Flywoo — der Weg zu besserer Regler-Firmware bleibt damit offen:

> **Bluejay statt BLHeli_S.** Die ab Werk aufgespielte Firmware lässt sich auf das offene
> **Bluejay** umflashen. Das bringt **bidirektionales DShot**, also Drehzahl-Rückmeldung
> vom Regler an die Flugsteuerung und damit RPM-Filterung. ESP-FC unterstützt das
> ausdrücklich. Kostet nichts außer einer halben Stunde — und ist ein schönes eigenes
> Kapitel über Regler-Firmware.
>
> Praktisch geht das **durch den XIAO hindurch**: ESP-FC hat eine ESC-Durchleitung
> (`MSP_PASSTHROUGH_ESC_4WAY`), BLHeliSuite spricht also über den Flugrechner mit den
> Reglern. Kein separater Programmieradapter nötig.

**Was sich gegenüber der ursprünglichen Planung änderte:** 5,2 g statt 2,5 g und
**20 × 20 mm statt 16 × 16 mm Lochbild**. Die Trägerplatine muss deshalb auf 20 × 20
ausgelegt werden. Die 2,7 g Mehrgewicht ändern an der Flugzeit praktisch nichts.

### Rückfallweg: vier Einzelregler

Falls auch der HAKRC ausgeht — Einzelregler für 2–4S gibt es reichlich (SPEDIX ES25 ~10,50 €,
HSKRC 20A ~9 €, HGLRC 30A ~9,20 €). Vier Stück kosten etwa so viel wie ein 4-in-1, wiegen
zusammen mehr und brauchen mehr Lötstellen. **Dafür hat das für ein Schulprojekt ein
Argument:** Geht beim Absturz einer kaputt, tauscht man einen Regler für 10 € statt der
ganzen Platine.

## Akku: zwei 18650-Zellen in Reihe

Ausdauer-Drohnen fliegen **Lithium-Ionen-Rundzellen** statt der sonst üblichen LiPos. Der
Grund: Rundzellen speichern deutlich mehr Energie pro Gramm, können dafür weniger Strom
liefern. Für ein Gerät, das gemütlich schweben soll, ist das der richtige Tausch — für ein
Rennquad wäre es der falsche.

**Und genau hier wird es rechnerisch interessant.** Im Schwebeflug braucht unser Gerät
grob 60–70 W, bei 7,4 V also **~9 A**. Im Vollgas ziehen die vier Motoren zusammen aber
**~36 A** — und in einer Reihenschaltung fließt dieser Strom durch **jede einzelne Zelle**.

Aus den Messungen von lithiumionfpv.com (die Zellen unter echter Last testen, nicht nach
Herstellerangabe):

| Zelle | real belastbar | Herstellerangabe | geeignet? |
|---|---|---|---|
| **Eve 30PL** | 40 A | — | **ja** |
| **Ampace JP30** | 45 A | — | **ja** |
| Linkdata 65P | 25 A | 52 A | nein |
| Samsung 25R | 20 A | — | nein |

**Entschieden: Eve 30PL oder Ampace JP30.** Beide reichen, mit wenig Luft nach oben.

> Der Unterschied zwischen angegebener und gemessener Belastbarkeit (52 A gegen 25 A bei
> der Linkdata) ist ein lohnendes Detail für die schriftliche Arbeit: Datenblattwerte sind
> nicht immer Messwerte.

Der Zellhalter bekommt **Kupferkontakte** — gemessen besser als die üblichen
Messingkontakte, weil Kupfer besser leitet und bei 36 A jeder Milliohm zählt.

## Gewichtsbudget

| Teil | Gewicht |
|---|---|
| Rahmen 2,5 mm CF, 90 × 90 mm | 12,0 g |
| 4 × 1204-Motor | 24,0 g |
| 4-in-1-Regler HAKRC 15A | 5,2 g |
| eigene Trägerplatine, fertig bestückt | 10,0 g |
| XIAO ESP32-S3 | 3,5 g |
| ELRS-Empfänger | 1,0 g |
| 4 × 2,8"-Propeller | 4,0 g |
| Zellhalter, Kabel, Stecker | 12,0 g |
| Schrauben, Kleinteile | 3,0 g |
| **Trocken** | **~74,7 g** |
| + 2 × 18650 Eve 30PL | 89,2 g |
| **Abflug** | **~164 g** |

Daraus die Flugzeitschätzung von **11–19 Minuten** — das untere Ende des Ziels von
15–30 min, nicht die Mitte. Der einzige wirksame Hebel wäre weniger Trockengewicht.

> **Achtung für den Rahmen:** 164 g Abfluggewicht sind mehr als jeder in den ausgewerteten
> Bruchtests geprüfte 3"-Aufbau. Zusatzmasse ist genau das, was Rahmen zerlegt hat — bei
> 2,5 mm Carbon bleiben und an den Armansätzen nicht sparen.
