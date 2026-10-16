# AnaOS common board config fragment (TASK_015)
# Included from device/anaos/<codename>/BoardConfig.mk once device trees exist.

TARGET_NO_BOOTLOADER := false
BOARD_USES_RECOVERY_AS_BOOT := false

# Verified boot / AVB — concrete keys wired at signing time (TASK_020 / TASK_026)
BOARD_AVB_ENABLE := true
