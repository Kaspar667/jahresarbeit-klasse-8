# Bestellliste

*Stand 25.09.2026. **Version 1 fliegt erst einmal ohne Kamera**, sie wird später nachgerüstet
(siehe „Später: Kamera" unten). Lieferzeit aus China erfahrungsgemäß zwei bis drei Wochen,
bei deutschen FPV-Händlern (FPV24, Quadmula, n-Factory) wenige Tage, dafür etwas teurer.*

Preise sind grobe Richtwerte.

## Bestellt

- [x] **4 × Happymodel EX1204, 6500 KV**: AliExpress (DronePartsPro), 36,39 € + 4,86 € Versand
- [x] **2 × HAKRC 4-in-1-Regler 15 A, 2–4S, 20 × 20 mm**: AliExpress (Wing Pules Model),
      20,99 € + 4,35 € Versand

> **Bei Ankunft prüfen:** Motoren müssen **6500 KV** sein (nicht 5000 KV), Regler **15 A**
> (nicht 25 A), und vier Motoren im Karton.

## Einkaufsliste

### 1. Sensoren und Flugrechner: zuerst bestellen, ohne die fliegt nichts

| ✓ | Teil | Worauf achten | ca. |
|---|---|---|---|
| [ ] | **MPU-6050-Modul (GY-521)** | 2–3 Stück kaufen, sind billig und gehen beim Löten gern kaputt | 3–8 € |
| [ ] | **BMP280-Modul, I2C, 3,3 V** | nicht BME280/BMP180 verwechseln; 2–3 Stück | 3–8 € |
| [ ] | **Seeed XIAO ESP32-S3** | neu kaufen, dann bleibt die ESP-FLY flugfähig | ~9 € |

### 2. Fernsteuerung (ELRS 2,4 GHz)

| ✓ | Teil | Worauf achten | ca. |
|---|---|---|---|
| [ ] | **RadioMaster Pocket, ELRS-Version** | **nicht** die CC2500-Version | 70–100 € |
| [ ] | **2 × 18650 für die Pocket** | die Pocket läuft mit 18650-Zellen, die sind nicht dabei; normale Qualitätszellen reichen hier | ~10 € |
| [ ] | **ELRS-Empfänger 2,4 GHz**, z.B. RadioMaster RP1 oder Happymodel EP2 | **5-V-tauglich** (Datenblatt!), 2,4 GHz wie der Sender | 10–15 € |

### 3. Akku und Laden

| ✓ | Teil | Worauf achten | ca. |
|---|---|---|---|
| [ ] | **4 × 18650 Eve 30PL oder Ampace JP30** | **nur diese beiden** schaffen die ~36 A; 4 Stück = 2 Sätze zum Wechseln | 25–35 € |
| [ ] | **Zellhalter 2 × 18650 in Reihe** | mit **Kupferkontakten**, leicht | ~5 € |
| [ ] | **Ladegerät für 18650**, 4 Schächte (z.B. XTAR, Nitecore) | Zellen **einzeln** laden, dann sind sie automatisch ausgeglichen | 20–30 € |

### 4. Trägerplatine

| ✓ | Teil | Worauf achten | ca. |
|---|---|---|---|
| [ ] | **5-V-Schaltregler, fest 5 V, mind. 1,5 A**, z.B. Pololu D24V22F5 | ohne Kamera würden 500 mA reichen; die 1,5 A kosten kaum mehr und machen die Kamera später nachrüstbar | ~12 € |
| [ ] | Schottky-Diode SS14 / B5819W | | |
| [ ] | MOSFET 2N7002 (SOT-23) | für den Summer | |
| [ ] | Widerstände 0805: 10 kΩ (2×), 5,1 kΩ, 100 Ω | Spannungsteiler, Gate | |
| [ ] | Kondensatoren 0805: 100 nF, 10 µF | | |
| [ ] | **Elko 470 µF / 25 V, Low-ESR** | an die Akkupads des Reglers | ~1 € |
| [ ] | Summer, **aktiv**, 5 V, 12 mm | aktiv = macht den Ton selbst | ~1 € |
| [ ] | Buchsenleisten 2 × 7-polig, Stiftleisten 2,54 mm | für den steckbaren XIAO | ~3 € |
| [ ] | **Platinenmaterial FR4, einseitig, 1,0 mm** | 1,0 statt 1,6 mm spart ~1,8 g | ~5 € |
|  | *Kleinteile zusammen* | am besten bei einem Elektronikhändler in einer Bestellung | ~10 € |

### 5. Propeller, Kabel, Schrauben

| ✓ | Teil | Worauf achten | ca. |
|---|---|---|---|
| [ ] | **HQProp T2.8×1.6×3 (2816), 1,5-mm-Bohrung** | **6 Paar, CW und CCW**, genau daran ist Schritt 1 gescheitert | ~15 € |
| [ ] | XT30-Stecker (Paare) | | ~5 € |
| [ ] | Silikonlitze 18 AWG (Akku) und 26–28 AWG (Signal) | | ~5 € |
| [ ] | M2-Schrauben, M2-Abstandshülsen, **Gummitüllen** | Motoren 9 × 9, Regler 20 × 20, Softmount | ~10 € |
| [ ] | Flüssiges Isolierband, Schrumpfschlauch | Kohlefaser leitet Strom! | ~10 € |
| [ ] | **Smoke-Stopper** (oder Sicherung) fürs erste Einschalten | verhindert, dass ein Lötfehler gleich alles abbrennt | ~10 € |
| [ ] | Kohlefaserplatte 2,5 mm | **nur falls die vorhandene nicht 2,5 mm dick ist** | |

### Summe

Grob **260–300 €**. Der größte Posten ist die Fernsteuerung (~85 €), die ist aber auch für
spätere Projekte weiter nutzbar.

## Später: Kamera

Die Kamera kommt in einer späteren Version dazu. Die Platine wird **jetzt schon** so gebaut,
dass das ohne Umbau geht: 5-V-Regler mit ≥ 1,5 A und der Anschluss **J5 (5 V, GND)** für
Kamera und Videosender. Das kostet jetzt fast nichts und hält die Tür offen, genau wie die
GPS-Pads.

Geplant ist analoges FPV (Live-Bild in der Videobrille, Aufnahme über deren Rekorder):

| ✓ | Teil | Worauf achten | ca. |
|---|---|---|---|
| [ ] | **Analoge FPV-Kamera, Nano-Größe (14 mm)**, z.B. Caddx Ant | Eingang muss **5 V** können; ~2 g | 15–20 € |
| [ ] | **Kleiner 5,8-GHz-Videosender (VTX)** | Eingang **5 V**, **auf 25 mW einstellbar** (in Deutschland das Maximum), Kanal per **Taste** einstellbar | 15–20 € |
| [ ] | **5,8-GHz-Antenne** | **Stecker muss zum VTX passen** (meist U.FL/IPEX) | ~5 € |
| [ ] | **Videobrille mit Rekorder (DVR)**, z.B. Eachine EV800D | analog 5,8 GHz, **mit DVR**, dann wird das Video gleich aufgenommen | 80–100 € |

> **Warum diese Kombination zusammenpasst:**
> - Kamera und VTX hängen am **5-V-Ausgang unserer Platine**. Dadurch braucht die Kamera
>   **keinen einzigen GPIO**, die Pinbelegung des XIAO bleibt unverändert.
> - Der VTX wird per Taste eingestellt, nicht per SmartAudio, weil SmartAudio einen freien
>   UART bräuchte, und den haben wir nicht.
> - Kein Bildschirm-Overlay (OSD) im Video: ESP-FC hat dafür keinen Chip. Die Akkuspannung
>   kommt stattdessen über die ELRS-Telemetrie auf das Display der Pocket.
> - Video läuft auf **5,8 GHz**, Fernsteuerung und ESP-NOW auf **2,4 GHz**, also stören sie
>   sich nicht gegenseitig.

**Was die Kamera dann ändert:** ~8 g mehr (~172 g statt ~164 g) und etwa 10 % weniger
Flugzeit (geschätzt ~10–16 min statt 11–18). Die Rechnung: Schwebeleistung wächst mit
Masse^1,5, also (172/164)^1,5 ≈ 1,07, dazu etwa 2 W für Kamera und Sender. Zusatzkosten
~120–150 €.

## Vorschriften (mit den Eltern klären)

- **Drohnen-Haftpflichtversicherung** ist in Deutschland Pflicht, für jede Drohne, auch ohne
  Kamera.
- *Erst wenn die Kamera dazukommt:* Betreiber beim Luftfahrt-Bundesamt (LBA) registrieren
  (bei Minderjährigen die Eltern), mit Videobrille nur mit Beobachter fliegen, Videosender
  auf höchstens 25 mW.

## Was „ESP-FC-kompatibel" überhaupt heißt

Eine Frage, die in der Recherche mehrfach auftauchte und die sich lohnt, in der Arbeit zu
klären. Die Kette ist:

```
Firmware  ->  Regler  ->  Motor
```

**Nur der Regler spricht mit der Firmware.** Der Motor sieht lediglich drei Phasen vom
Regler und weiß nichts davon, welche Software im Flugrechner läuft. „Ist dieser Motor mit
ESP-FC kompatibel?" ist deshalb keine sinnvolle Frage. Bei Motoren zählen KV-Zahl zur
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
- **Ersatz mitbestellen, wo es billig ist:** Propeller, Sensormodule, ein fünfter Motor, der
  zweite Regler (ist schon drin). Der erste Absturz kommt bestimmt.
- **Später bei Kamera, VTX und Antenne vor dem Kauf prüfen:** Eingangsspannung 5 V möglich?
  Antennenstecker passend? Das sind die zwei häufigsten Fehlkäufe.
- Zwei verschiedene Verkäufer heißt zwei Sendungen, zwei Versandkosten und
  unterschiedliche Ankunftszeiten.
