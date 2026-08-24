# Jahresarbeit: Bau einer Kamera-Drohne

Jahresarbeit der 8. Klasse an der Rudolf Steiner Schule Berlin (Dahlem).

Ein selbst gewähltes Projekt aus **Theorie und Praxis**: über mehrere Monate wird
eine Kamera-Drohne entwickelt und gebaut, dokumentiert und am Ende vor der
Schulgemeinschaft präsentiert.

## Aufbau in drei Schritten

Das Projekt nähert sich der fertigen Kamera-Drohne in drei aufeinander aufbauenden
Stufen — von einfach zu komplex:

| Schritt | Projekt | Ordner | Ziel |
|--------:|---------|--------|------|
| 1 | Holz-Bausatz (Amazon) | [`01-holzbausatz/`](01-holzbausatz/) | Erste Erfahrungen: Zusammenbau, Motoren, Propeller, Fliegen lernen |
| 2 | ESP-FLY (ESP32-S3) | [`02-esp-fly/`](02-esp-fly/) | Eigene Flugsoftware verstehen: Firmware bauen, flashen, Sensor & Steuerung |
| 3 | Kamera-Drohne | [`03-kamera-drohne/`](03-kamera-drohne/) | Vollständige Drohne mit Kamera als Abschlusswerk |

## Ordnerstruktur

```
jahresarbeit-drohne/
├── README.md              ← dieses Dokument (Überblick)
├── docs/                  ← schriftliche Ausarbeitung, Notizen, Präsentation
├── 01-holzbausatz/        ← Schritt 1
├── 02-esp-fly/            ← Schritt 2 (enthält Firmware als Git-Submodul)
└── 03-kamera-drohne/      ← Schritt 3
```

## Schriftliche Arbeit

Die Ausarbeitung liegt in [`docs/`](docs/). Jeder Bauschritt hat außerdem eine
eigene `README.md` im jeweiligen Ordner, in der Vorgehen, Probleme und Lösungen
festgehalten werden — das bildet später das Rückgrat der schriftlichen Arbeit.
