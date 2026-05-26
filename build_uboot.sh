#!/usr/bin/env bash
set -e
# Clean previous builds
make -C u-boot distclean
# Load configuration for the ATR Station board (already present as atr_station_defconfig)
make -C u-boot atr_station_defconfig
# Build U‑Boot using the AArch64 cross‑compiler
make -C u-boot -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
# Show the resulting binary location
echo "U‑Boot built successfully: $(realpath u-boot/u-boot)"
# Sign FIP
./sign_uboot_sei610.sh
