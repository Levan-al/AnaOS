# Minimal emulator board stub for AnaOS lunch discovery.
# Refine against the synced AOSP goldfish paths after first overlay
# (trunk may use device/generic/goldfish/... variants).

TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64
TARGET_CPU_ABI := x86_64

TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64
TARGET_2ND_CPU_ABI := x86

TARGET_BOOTLOADER_BOARD_NAME := anaos_emulator
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true

BOARD_SYSTEMIMAGE_PARTITION_SIZE := 3221225472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800

# Prefer goldfish common board if present in this AOSP pin
-include device/generic/goldfish/board/BoardConfigCommon.mk
