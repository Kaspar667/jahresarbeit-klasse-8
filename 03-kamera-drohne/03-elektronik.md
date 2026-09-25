# Elektronik: Flugrechner, Software, Fernsteuerung

*Derselbe Mikrocontroller wie in Schritt 2 — aber eine andere Software und eine völlig
andere Leistungsklasse.*

## Der Flugrechner: XIAO ESP32-S3

Bewusst derselbe Mikrocontroller wie in der ESP-FLY aus Schritt 2. Damit ist Schritt 3
keine Neuanfang, sondern eine **Weiterentwicklung**: Kaspar kennt das Modul, die
Entwicklungsumgebung und das Flashen bereits.

> **Wichtig, weil es leicht übersehen wird:** Der XIAO ESP32-S3 hat **keinen Kreisel an
> Bord**. In der ESP-FLY saß der Sensor auf dem Trägerboard. Ohne eigenes Kreiselmodul gibt
> es keine Flugregelung — das ist der Posten in der Bestellliste, den man am leichtesten
> vergisst und der am sichersten alles aufhält.

## Die Software: ESP-FC statt ESP-Drone

In Schritt 2 lief **ESP-Drone** (von Espressif). Die kann keine bürstenlosen Motoren
ansteuern: Im Quelltext ist Brushless angelegt, aber nicht aktiviert, und die Ausgänge
sprechen Bürsten-PWM. Sie ließe sich erweitern — das wäre aber ein eigenes, großes Projekt.

**Entschieden: [ESP-FC](https://github.com/rtlopez/esp-fc)** von rtlopez. Eine offene
Flugsoftware, die Betaflight nachempfunden ist. Was sie mitbringt:

| | |
|---|---|
| Zielplattform | ESP32-S3 ausdrücklich unterstützt |
| Reglerprotokolle | **DShot150/300/600**, auch bidirektional |
| Empfänger | CRSF/ELRS, SBUS, IBUS, PPM **und ESP-NOW — gleichzeitig im selben Firmware-Stand** |
| Kreisel | MPU6050, MPU6000/6500/9250, ICM20602, ICM42688, BMI160 |
| Weiteres | Barometer, GPS, Blackbox, MSP- und CLI-Schnittstelle |
| Rahmenform | nur `QUADX` — vier Motoren, das passt |

Konfiguriert wird mit dem **Betaflight-Configurator** über USB, oder drahtlos über den
eingebauten Zugangspunkt `ESP-FC` unter `tcp://192.168.4.1:1111`.

### Was Kaspar dabei selbst programmiert

Nicht die Flugregelung — die zu schreiben wäre unrealistisch und auch nicht der Punkt.
Selbst gemacht wird:

- die **Konfiguration** der Firmware auf die eigene Hardware (siehe Pinbelegung unten),
- die **Anpassung von Kaspars Handy-App** auf den ESP-NOW-Transport,
- später der **Raspberry-Pi-Code** für die Gestenerkennung (Stufe 3),
- und in Stufe 2 die Inbetriebnahme des eigenen Reglers mit AM32.

## Steuerarchitektur: drei Wege auf einen Eingang

ESP-FC nimmt mehrere Eingänge gleichzeitig entgegen. Das nutzen wir bewusst — und es ist
der eleganteste Teil des ganzen Entwurfs:

**ELRS über CRSF (UART)** — die ernsthafte Fernsteuerung. Kilometer Reichweite, richtiges
Failsafe, funktioniert auch, wenn WLAN stört. Empfänger ~10–15 €, Sender (z.B. RadioMaster
Pocket) ~100 €. **Das ist der Sicherheitsanker: was immer sonst passiert, die Fernsteuerung
übersteuert.**

**ESP-NOW** — kurze Strecke, wenig Latenz. Hier hängt Kaspars iPhone-App an, und später der
Raspberry Pi mit der Gestenerkennung.

**MSP** — zum Einstellen und Auslesen mit dem Betaflight-Configurator.

> **Der Gewinn:** Gestensteuerung, Handy-App und Fernsteuerung sprechen **denselben
> Eingang** — RC-Kanäle. Wer später etwas Neues anschließen will, muss am Fluggerät nichts
> ändern. Und es gibt immer eine Instanz, die alles übersteuern kann. Das ist die
> Bedingung dafür, dass man so ein Gerät überhaupt fliegen lässt.

## Das Pin-Budget — die Entscheidung hinter der Sensorik

Der XIAO ESP32-S3 führt **elf GPIOs** heraus: 1–9, 43, 44. Mehr gibt es nicht, und das ist
knapp. Die Aufteilung:

| Funktion | Pins | Rest |
|---|---|---|
| 4 Motorsignale (DShot) | 4 | 7 |
| ELRS-Empfänger (UART) | 2 | 5 |
| **I2C-Bus** | 2 | 3 |
| Akkuspannung (ADC) | 1 | 2 |
| Summer | 1 | 1 |
| GPIO3 bleibt frei (Strapping-Pin) | — | 1 |

**Der entscheidende Punkt: I2C ist ein Bus.** Kreisel, Barometer und Magnetometer hängen
alle an denselben zwei Leitungen, jedes mit eigener Adresse. **Ein Barometer kostet also
null zusätzliche Anschlüsse.** Alles, was eine eigene Schnittstelle braucht — GPS über
UART — kostet dagegen zwei, und die haben wir nicht.

Daraus folgt die Sensorwahl, ausführlich in [`04-traegerplatine.md`](04-traegerplatine.md):
Kreisel und Barometer ja, Magnetometer und GPS nein.

### Warum I2C und nicht SPI

ESP-FC empfiehlt SPI für den Kreisel, weil es höhere Abtastraten erlaubt (Richtung 8 kHz
statt 1 kHz). SPI braucht aber **vier** Pins (SCK, MOSI, MISO, CS). Dann sind alle elf
belegt — **kein Barometer, kein Summer**.

**Entschieden: I2C.** Die höhere Abtastrate lohnt bei einem Rennquad, nicht bei einem
ruhigen Ausdauergerät. Höhenhaltung und Summer sind hier mehr wert. Wer später mehr
Regelrate will, opfert Summer und Spannungsmessung und nimmt einen ICM-42688 über SPI.

## Pinbelegung

Die Standardbelegung von ESP-FC auf dem ESP32-S3 passt **nicht** zum XIAO: Motoren liegen
dort auf GPIO 39–42 und der I2C-Takt auf GPIO 10 — **die gibt es am XIAO gar nicht.** Die
Pins müssen also zwingend umgelegt werden. Das ist vorgesehen, nicht geduldet: Im Quelltext
ist für dieses Ziel `ESPFC_SERIAL_REMAP_PINS` gesetzt.

| Funktion | XIAO-Beschriftung | GPIO |
|---|---|---|
| Motor 1 | D0 | 1 |
| Motor 2 | D1 | 2 |
| Motor 3 | D3 | 4 |
| Motor 4 | D8 | 7 |
| Kreisel/Barometer SDA | D4 | 5 |
| Kreisel/Barometer SCL | D5 | 6 |
| ELRS-Empfänger, Signal | D7 | 44 |
| ELRS-Empfänger, Telemetrie | D6 | 43 |
| Akkuspannung (über Teiler) | D9 | 8 |
| Summer | D10 | 9 |
| **frei lassen** | D2 | 3 |

> **Warum D2 frei bleibt:** GPIO3 ist am ESP32-S3 ein **Strapping-Pin** — sein Zustand beim
> Einschalten beeinflusst, wie der Chip startet. Als Motorausgang wäre das ein unnötiges
> Risiko.

### Die Befehle in der ESP-FC-Kommandozeile

```
set pin_output_0 1
set pin_output_1 2
set pin_output_2 4
set pin_output_3 7
set pin_i2c_sda 5
set pin_i2c_scl 6
set pin_input_adc_vbat 8
set pin_buzzer 9
set pin_input_rx -1        # PPM lag auf GPIO 6, den brauchen wir fuer SCL
set pin_spi_cs_0 -1        # SPI-Chipselects lagen auf 7 und 8
set pin_spi_cs_1 -1
set motor_pwm_protocol DSHOT300
set motor_poles 12
save
```

Anmerkungen:

- **DShot300 zum Anfangen**, nicht 600 — mehr Zeitreserve auf den Leitungen. Läuft es
  sauber, kann man hochgehen.
- `motor_poles 12` gilt für 1204-Motoren und wird für die Drehzahl-Telemetrie gebraucht.
- **Motorreihenfolge** nach Betaflight-Konvention QUADX: M1 hinten rechts, M2 vorne rechts,
  M3 hinten links, M4 vorne links. Die Drehrichtung ändert man durch Tauschen zweier
  Motorphasen oder in der Regler-Firmware.
- Die Signalleitungen sind **3,3-V-Logik**. BLHeli_S-Regler nehmen das an; auch fertige
  Flugsteuerungen geben 3,3 V aus.
- **Der ELRS-Empfänger braucht zusätzlich eine Umstellung im Configurator:** Im Reiter
  *Ports* muss die **Funktion** von Serial 0 von MSP auf *Serial RX* umgestellt werden,
  nicht nur der Pin. MSP bleibt über USB erreichbar.

## Geprüft am Quelltext (23.09.2026)

Nachgesehen im geklonten Stand von github.com/rtlopez/esp-fc:

- `TargetESP32s3.h` definiert `ESPFC_OUTPUT_COUNT 4` — vier Motorausgänge, und das Umlegen
  der Pins ist für dieses Ziel offiziell vorgesehen.
- Die DShot-Erzeugung läuft über die **RMT-Einheit** des ESP32, inklusive Umschalten auf
  Empfang für die bidirektionale Telemetrie. Der ESP32-S3 hat **genau vier**
  RMT-Sendekanäle — für vier Motoren reicht das exakt, Reserve gibt es keine. Ein fünfter
  Ausgang wäre nicht drin.
- Die Höhenhaltung (`MODE_ALTHOLD`) regelt auf die Steig- und Sinkrate aus der
  Höhenschätzung — die kommt vom **Barometer**. Ohne Barometer keine Höhenhaltung.
- ESP-FC kann **ESC-Durchleitung** (`MSP_PASSTHROUGH_ESC_4WAY`): Bluejay lässt sich durch
  den XIAO hindurch auf die Regler flashen.

**Ergebnis: XIAO ESP32-S3 + ESP-FC + HAKRC 15A passen zusammen.** Signalpegel 3,3 V,
DShot150/300/600 auf beiden Seiten, 2–4S deckt unsere 2S ab.
