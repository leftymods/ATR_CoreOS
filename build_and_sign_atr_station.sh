#!/usr/bin/env bash
set -e
# Build U-Boot first
make -C u-boot atr_station_defconfig
make -C u-boot -j$(nproc) CROSS_COMPILE=aarch64-linux-gnu-
# Get the built U-Boot with DTB for BL33
UBOOT_BIN="u-boot/u-boot-dtb.bin"
# Sign FIP using atr_station directory (same as sei610 for SM1 SoC)
make -C u-boot/fip/atr_station clean all BL33="$(realpath "$UBOOT_BIN")"
# Collect results
mkdir -p u-boot/fip_output
cp u-boot/fip/atr_station/u-boot.bin u-boot/fip_output/u-boot.bin
echo "Signed binary is in u-boot/fip_output/u-boot.bin"
