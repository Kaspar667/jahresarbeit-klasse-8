# ESP-FLY: Firmware bauen und flashen — Schritt-für-Schritt

Diese Anleitung führt von Null bis zur fliegenden Drohne. Getestet auf **macOS**.

## Überblick — welche Projekte brauchen wir?

| Projekt | Was ist das? | Wie eingebunden |
|---------|--------------|-----------------|
| **esp-drone** | Die Flug-Software (Firmware) der Drohne | Submodul `esp-drone/` |
| **esp-idf** | Die Bau-Umgebung von Espressif (Compiler, Werkzeuge) | Submodul `esp-idf/` (v5.0) |
| *esp-now u. a.* | Zusatz-Bausteine der Firmware | lädt der Build automatisch nach |

`esp-drone` allein reicht nicht — sie ist nur der Quelltext. Zum *Übersetzen* in
ein Programm, das der Chip versteht, braucht man **ESP-IDF**.

---

## Schritt 0 — Projekt holen (inkl. Submodule)

```bash
git clone --recurse-submodules git@github.com:Kaspar667/jahresarbeit-klasse-8.git
cd jahresarbeit-klasse-8/02-esp-fly
```

Falls schon geklont, aber die Submodule fehlen (leere Ordner `esp-drone/`,
`esp-idf/`):

```bash
git submodule update --init --recursive
```

> ⚠️ ESP-IDF ist groß (~1,7 GB). Der erste Download dauert ein paar Minuten.

---

## Schritt 1 — ESP-IDF einmalig einrichten

ESP-IDF muss einmal seine Compiler/Werkzeuge herunterladen (nach `~/.espressif`):

```bash
cd esp-idf
./install.sh esp32s3
cd ..
```

---

## Schritt 2 — Firmware bauen

```bash
cd esp-drone
. ../esp-idf/export.sh        # lädt ESP-IDF ins Terminal (in JEDEM neuen Terminal nötig)
idf.py set-target esp32s3     # holt die ESP-FLY-Pins aus sdkconfig.defaults.esp32s3
idf.py build                  # baut die Firmware -> build/ESPDrone.bin
cd ..
```

Am Ende steht sinngemäß: `Project build complete.`

---

## Schritt 3 — Auf die Drohne flashen

Drohne per **USB-Kabel** an den Mac anstecken, dann:

```bash
./flash.sh
```

Das Skript findet ESP-IDF und den USB-Port automatisch. Alternativ Port angeben:

```bash
./flash.sh /dev/cu.usbmodem101
```

Fertig, wenn `Hash of data verified.` und `Hard resetting...` erscheinen.

---

## Schritt 4 — Fliegen

1. Handy ins WLAN **`ESP-DRONE_...`** einwählen — Passwort `12345678`.
2. **ESP-Drone App** (iOS/Android, von Espressif) öffnen → **Connect**.

---

## Kontrolle: Läuft die Drohne richtig? (Boot-Log lesen)

Nützlich zur Fehlersuche. Liest die Log-Ausgabe der Drohne über USB:

```bash
cd esp-drone
. ../esp-idf/export.sh
idf.py -p /dev/cu.usbmodem101 monitor      # beenden mit Strg+]
```

Gut ist:

```
SENSORS: MPU6050 I2C connection [OK].
SYS: systemTest = 1     COMM: crtpTest = 1     SYS: stabilizerTest = 1
```

---

## Häufige Probleme

| Symptom | Ursache | Lösung |
|---------|---------|--------|
| `MPU6050 I2C connection [FAIL]` | falsche Pins / falsches Board-Target | `idf.py set-target esp32s3` (nimmt die richtigen ESP-FLY-Pins), neu bauen & flashen |
| App verbindet nicht | Sensor-Selbsttest scheitert (s. o.) | siehe oben — erst muss der MPU6050 `[OK]` sein |
| Kein `/dev/cu.usbmodem*` | Kabel/Port | anderes USB-Kabel (Datenkabel!), anderer Port; ggf. USB-Treiber |
| `VL53L1X`/`PMW3901`/`Z-down` `[FAIL]` | optionale Sensoren nicht verbaut | **normal** beim ESP-FLY — nur Warnungen, kein Problem |
| Build-Fehler `protocomm_security1` o. ä. | falsche ESP-IDF-Version | ESP-IDF muss **v5.0** sein (Submodul ist darauf gepinnt) |

---

## Warum diese ESP-IDF-Version?

Die Firmware `esp-drone` wurde für **ESP-IDF release/v5.0** geschrieben. Neuere
Versionen (v6.x) haben geänderte Schnittstellen und der Build schlägt fehl.
Das Submodul `esp-idf/` ist deshalb fest auf die passende v5.0-Version gepinnt.
