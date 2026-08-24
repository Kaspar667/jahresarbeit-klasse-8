# Schritt 2 — ESP-FLY (ESP32-S3)

Die [ESP-FLY](https://github.com/Seeed-Projects/Co-Create_ESP-FLY) ist eine winzige
Drohne auf Basis des Mikrocontrollers **Seeed XIAO ESP32-S3**. In diesem Schritt
geht es nicht nur ums Bauen, sondern darum, die **Flugsoftware (Firmware) selbst
zu verstehen, anzupassen und auf die Drohne zu spielen**.

## Was hier drin ist

- **`esp-drone/`** — die Firmware als **Git-Submodul** auf unseren Fork
  [`spieker/esp-drone`](https://github.com/spieker/esp-drone), Branch
  `jahresarbeit-klasse-8`. Hier stehen unsere board-spezifischen Anpassungen.
- **`flash.sh`** — spielt die gebaute Firmware auf die Drohne (per USB).

## Voraussetzung: ESP-IDF v5.0

Die Firmware wird mit **ESP-IDF v5.0** gebaut (die Entwicklungsumgebung von
Espressif). Sie ist bewusst *nicht* Teil dieses Projekts, weil sie sehr groß ist
(~1,7 GB) und eine externe Werkzeugkiste ist. Installation:

```bash
mkdir -p ~/esp && cd ~/esp
git clone -b release/v5.0 --recursive https://github.com/espressif/esp-idf.git
cd esp-idf && ./install.sh esp32s3
```

`flash.sh` findet ESP-IDF automatisch unter `~/esp/esp-idf` oder über die
Umgebungsvariable `IDF_PATH`.

## Firmware bauen und flashen

```bash
# einmalig, im Firmware-Ordner:
cd esp-drone
. ~/esp/esp-idf/export.sh        # ESP-IDF laden
idf.py set-target esp32s3        # zieht die ESP-FLY-Pins aus sdkconfig.defaults.esp32s3
idf.py build                     # baut die Firmware

# Drohne per USB anstecken, dann aus dem esp-fly-Ordner:
cd ..
./flash.sh                       # findet den Port automatisch
```

Zum Fliegen: Handy ins WLAN `ESP-DRONE_...` (Passwort `12345678`), dann die
**ESP-Drone App** öffnen und verbinden.

## Unsere Anpassungen (das Wichtigste zum Dokumentieren)

Die Standard-Firmware von Espressif geht von *anderen* Pins aus als das
ESP-FLY-Board. Ergebnis: der Bewegungssensor (MPU6050) meldete beim Start
`MPU6050 I2C connection [FAIL]`, und die App konnte sich nicht verbinden.

Lösung — in `esp-drone/sdkconfig.defaults.esp32s3` die richtigen Pins des
ESP-FLY-Boards eingetragen:

| Bauteil | Signal | GPIO |
|---------|--------|-----:|
| MPU6050 (Sensor) | I2C SDA | 5 |
| MPU6050 (Sensor) | I2C SCL | 6 |
| MPU6050 (Sensor) | INT | 8 |
| Motor 1 | PWM | 7 |
| Motor 2 | PWM | 4 |
| Motor 3 | PWM | 3 |
| Motor 4 | PWM | 1 |

Motortyp: brushed **715**. Danach: `MPU6050 I2C connection [OK]` — Sensor läuft,
App verbindet sich, Drohne fliegt.

> **Lernpunkt:** Software muss zur konkreten Hardware passen. Derselbe Programmcode
> funktioniert erst, wenn er weiß, an welchen Anschlüssen (Pins) des Chips die
> Bauteile wirklich hängen.
