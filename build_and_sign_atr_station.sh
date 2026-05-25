#!/usr/bin/env bash
set -e
# Build U‑Boot if not present
if [ ! -f u-boot/u-boot ]; then
  echo "Building U‑Boot..."
  make -C u-boot distclean
  make -C u-boot ARCH=arm atr_station_defconfig
  make -C u-boot -j$(nproc) ARCH=arm CROSS_COMPILE=aarch64-linux-gnu-
fi
# Copy binary for FIP signing
cp u-boot/u-boot u-boot/fip/sei610/u-boot.bin
# Build signed FIP (using dummy kernel image for BL33)
make -C u-boot/fip/sei610 clean all BL33=$(pwd)/dummy.bin
# Collect results
mkdir -p u-boot/fip_output
cp u-boot/fip/sei610/*.bin u-boot/fip_output/
echo "Signed binaries are in u-boot/fip_output"
