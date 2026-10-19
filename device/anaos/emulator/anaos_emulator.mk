# AnaOS emulator product (TASK_015 / post-overlay lunch)
# Stock first build uses sdk_phone64_x86_64-* (remote-aosp-build.sh).
# This target is for AnaOS-branded lunch after overlay.

# sdk_phone64 defaults dynamic partitions to 1800MiB — too small once AnaOS
# overlays inflate product/system (lpmake: Not enough space for product).
# Set before inherit so ?= in sdk_phone64.mk keeps our value; SUPER is then
# derived as DYNAMIC + 8MiB.
BOARD_EMULATOR_DYNAMIC_PARTITIONS_SIZE := $(shell expr 3072 \* 1048576)

# Try common AOSP emulator product fragments (paths vary by pin)
$(call inherit-product-if-exists, device/generic/goldfish/64bitonly/product/sdk_phone64_x86_64.mk)
$(call inherit-product-if-exists, device/generic/goldfish/product/generic_x86_64.mk)
$(call inherit-product-if-exists, device/generic/goldfish/product/phone.mk)

$(call inherit-product, device/anaos/common/anaos.mk)

PRODUCT_NAME := anaos_emulator
# Must match directory name device/anaos/emulator/ (BoardConfig.mk lookup).
PRODUCT_DEVICE := emulator
PRODUCT_MODEL := AnaOS Emulator
PRODUCT_BRAND := Ana
PRODUCT_MANUFACTURER := AnaOS
PRODUCT_CHARACTERISTICS := emulator
