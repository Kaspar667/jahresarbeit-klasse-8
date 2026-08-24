#!/usr/bin/env bash
# Flasht die ESP-FLY Firmware (ESP32-S3) auf die Drohne.
# Nutzung: ./flash.sh                       # Port automatisch (usbmodem)
#          ./flash.sh /dev/cu.usbmodemXXX   # Port explizit
set -euo pipefail
HERE="$(cd "$(dirname "$0")" && pwd)"

# ESP-IDF v5.0 finden: lokales Submodul, sonst IDF_PATH, sonst ~/esp/esp-idf
IDF=""
for cand in "$HERE/esp-idf" "${IDF_PATH:-}" "$HOME/esp/esp-idf"; do
  if [ -n "$cand" ] && [ -f "$cand/export.sh" ]; then IDF="$cand"; break; fi
done
[ -n "$IDF" ] || { echo "ESP-IDF v5.0 nicht gefunden. Submodul holen (git submodule update --init --recursive 02-esp-fly/esp-idf) oder IDF_PATH setzen."; exit 1; }
echo "ESP-IDF: $IDF"
. "$IDF/export.sh" >/dev/null 2>&1

PORT="${1:-$(ls /dev/cu.usbmodem* 2>/dev/null | head -1 || true)}"
[ -n "$PORT" ] || { echo "Kein USB-Port gefunden. Drohne anstecken oder Port angeben."; exit 1; }
echo "Flashe ESP32-S3 auf $PORT ..."

cd "$HERE/esp-drone"
idf.py -p "$PORT" flash

echo
echo "Fertig. Zum Fliegen: WLAN 'ESP-DRONE_...' verbinden (Passwort 12345678),"
echo "dann die 'ESP-Drone' App (iOS/Android) oeffnen und verbinden."
