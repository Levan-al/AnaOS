# Emulator board for PRODUCT_DEVICE := emulator
# (path: device/anaos/emulator/BoardConfig.mk)

TARGET_ARCH := x86_64
TARGET_ARCH_VARIANT := x86_64
TARGET_CPU_ABI := x86_64

TARGET_2ND_ARCH := x86
TARGET_2ND_ARCH_VARIANT := x86_64
TARGET_2ND_CPU_ABI := x86

TARGET_BOOTLOADER_BOARD_NAME := anaos_emulator
TARGET_NO_BOOTLOADER := true
TARGET_NO_KERNEL := true

# Inherit goldfish partition/layout knobs when present — do not also set
# BOARD_SYSTEMIMAGE_PARTITION_SIZE here (conflicts with RESERVED_SIZE).
# Super/group size: see BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE in
# anaos_emulator.mk (must be set before sdk_phone64 inherit).
-include device/generic/goldfish/board/BoardConfigCommon.mk
