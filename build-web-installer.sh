#!/usr/bin/env bash
set -euo pipefail

ENV="esp32-2432s028r"
BUILD_DIR=".pio/build/$ENV"
OUT_DIR="static/firmware/$ENV"

echo "Building firmware..."
pio run -e "$ENV"

echo "Merging firmware binary..."
mkdir -p "$OUT_DIR"

BOOT_APP0=$(find . -path "*/boot_app0.bin" | head -1)

if [ -z "$BOOT_APP0" ]; then
  echo "boot_app0.bin not found, merging without it"
  esptool --chip esp32 merge-bin \
    -o "$OUT_DIR/merged.bin" \
    --flash-mode dio \
    --flash-freq 40m \
    --flash-size 4MB \
    0x1000  "$BUILD_DIR/bootloader.bin" \
    0x8000  "$BUILD_DIR/partitions.bin" \
    0x10000 "$BUILD_DIR/firmware.bin"
else
  esptool --chip esp32 merge-bin \
    -o "$OUT_DIR/merged.bin" \
    --flash-mode dio \
    --flash-freq 40m \
    --flash-size 4MB \
    0x1000  "$BUILD_DIR/bootloader.bin" \
    0x8000  "$BUILD_DIR/partitions.bin" \
    0xe000  "$BOOT_APP0" \
    0x10000 "$BUILD_DIR/firmware.bin"
fi

echo "Done: $OUT_DIR/merged.bin"
ls -lh "$OUT_DIR/merged.bin"