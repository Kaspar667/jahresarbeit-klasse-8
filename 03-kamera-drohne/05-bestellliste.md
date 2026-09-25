# Bestellliste

*Stand 23.09.2026. Lieferzeit aus China erfahrungsgemäß zwei bis drei Wochen — das gehört
in die Zeitplanung der Jahresarbeit.*

## Bestellt

- [x] **4 × Happymodel EX1204, 6500 KV** — AliExpress (DronePartsPro), 36,39 € + 4,86 € Versand
- [x] **2 × HAKRC 4-in-1-Regler 15 A, 2–4S, 20 × 20 mm** — AliExpress (Wing Pules Model),
      20,99 € + 4,35 € Versand

> **Bei Ankunft prüfen:** Motoren müssen **6500 KV** sein (nicht 5000 KV), Regler **15 A**
> (nicht 25 A), und vier Motoren im Karton.

Damit ist der Antrieb vollständig. Was fehlt, ist die Steuerungsseite.

## Noch offen

| Teil | Hinweis |
|---|---|
| **MPU-6050-Modul** (Kreisel) | **ohne den fliegt nichts** — der XIAO hat keinen Sensor an Bord |
| **BMP280-Modul** (Barometer) | für die Höhenhaltung |
| **HQProp T2.8×1.6×3 (2816)**, 1,5-mm-Bohrung | 6 Paar, **CW und CCW** |
| **ELRS-Empfänger** 2,4 GHz (CRSF) | ~10–15 € |
| **ELRS-Sender**, z.B. RadioMaster Pocket | ~100 €, der größte Einzelposten |
| **2 × 18650**: Eve 30PL oder Ampace JP30 | nur diese beiden schaffen die ~36 A |
| Zellhalter für zwei 18650 in Reihe | mit **Kupferkontakten** |
| Ladegerät für 18650 | |
| XIAO ESP32-S3 | falls nicht aus dem ESP-FLY-Bausatz übernommen |
| 5-V-Schaltregler + Schottky-Diode | für die Trägerplatine |
| Kondensator 220–470 µF / 25 V, Low-ESR | direkt an die Akkupads des Reglers |
| Widerstände 10 kΩ / 5,1 kΩ, Summer | Spannungsteiler und Warntongeber |
| XT30-Stecker, Silikonlitze | |
| M2-Schrauben und Abstandshülsen | Motoren (9 × 9) und Regler (20 × 20) |
| Kohlefaserplatte 2,5 mm | **Dicke der vorhandenen prüfen** |

> **Das Kreiselmodul ist der Posten, den man am leichtesten vergisst und der am sichersten
> alles aufhält.** Zuerst bestellen.

## Was „ESP-FC-kompatibel" überhaupt heißt

Eine Frage, die in der Recherche mehrfach auftauchte und die sich lohnt, in der Arbeit zu
klären. Die Kette ist:

```
Firmware  ->  Regler  ->  Motor
```

**Nur der Regler spricht mit der Firmware.** Der Motor sieht lediglich drei Phasen vom
Regler und weiß nichts davon, welche Software im Flugrechner läuft. „Ist dieser Motor mit
ESP-FC kompatibel?" ist deshalb keine sinnvolle Frage — bei Motoren zählen KV-Zahl zur
Zellenzahl, Lochbild und Wellendurchmesser.

- **HAKRC 15A 4-in-1:** BLHeli_S auf EFM8BB21, DShot600 → **ja, kompatibel**, am
  ESP-FC-Quelltext geprüft.
- **Happymodel EX1204:** firmwareunabhängig. Passt mechanisch (9 × 9 mm M2, 1,5-mm-Welle)
  und elektrisch zum Regler.

## Hinweise zum Bestellen

- **Vier gleiche Motoren sind in Ordnung**, auch wenn Anzeigen CW/CCW unterscheiden: Bei
  1,5-mm-Wellen werden die Propeller aufgesteckt, es gibt kein Gewinde, das sich losdrehen
  könnte. Die Drehrichtung wird in der Regler-Firmware gesetzt oder durch Tauschen zweier
  Phasenleitungen.
- **Bei den Propellern brauchen wir dagegen beide Drehrichtungen.** Genau daran ist der
  Holz-Bausatz aus Schritt 1 gescheitert.
- **Ersatz mitbestellen, wo es billig ist:** Propeller, ein fünfter Motor, der zweite
  Regler (ist schon drin). Der erste Absturz kommt bestimmt.
- Zwei verschiedene Verkäufer heißt zwei Sendungen, zwei Versandkosten und
  unterschiedliche Ankunftszeiten.
