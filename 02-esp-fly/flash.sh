#!/usr/bin/env bash
# Flasht die ESP-FLY Firmware (ESP32-S3) auf die Drohne.
# Nutzung: ./flash.sh                       # Port automatisch (usbmodem)
#          ./flash.sh /dev/cu.usbmodemXXX   # Port explizit
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"

# ESP-IDF v5.0 finden: IDF_PATH, sonst ~/esp/esp-idf
IDF="${IDF_PATH:-$HOME/esp/esp-idf}"
[ -f "$IDF/export.sh" ] || { echo "ESP-IDF v5.0 nicht gefunden unter '$IDF'. Setze IDF_PATH."; exit 1; }
. "$IDF/export.sh" >/dev/null 2>&1

PORT="${1:-$(ls /dev/cu.usbmodem* 2>/dev/null | head -1 || true)}"
[ -n "$PORT" ] || { echo "Kein USB-Port gefunden. Drohne anstecken oder Port angeben."; exit 1; }
echo "Flashe ESP32-S3 auf $PORT ..."

cd "$HERE/esp-drone"
idf.py -p "$PORT" flash

echo
echo "Fertig. Zum Fliegen: WLAN 'ESP-DRONE_...' verbinden (Passwort 12345678),"
echo "dann die 'ESP-Drone' App (iOS/Android) oeffnen und verbinden."
