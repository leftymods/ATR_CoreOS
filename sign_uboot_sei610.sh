#!/usr/bin/env bash
set -e
# Sign FIP for ATR Station using atr_station BL2/BL3 binaries (SM1 SoC)
pushd u-boot/fip/atr_station > /dev/null
make clean
UBOOT_BIN="/home/leftymods/AtriStation/u-boot/u-boot-dtb.bin"
make -j$(nproc) BL33="$UBOOT_BIN"
popd > /dev/null
# Gather signed binaries
mkdir -p u-boot/fip_output
cp u-boot/fip/atr_station/u-boot.bin u-boot/fip_output/
echo "Signed binary is in u-boot/fip_output/u-boot.bin"
