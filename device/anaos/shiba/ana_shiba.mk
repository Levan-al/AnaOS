# AnaOS Pixel 8 (shiba) product stub (TASK_028)
# Full vendor inheritance lands after adevtool extract (TASK_027 / TASK_029).

$(call inherit-product, device/anaos/common/anaos.mk)

# When vendor tree exists, also:
# $(call inherit-product, device/google/shiba/device-shiba.mk)
# or AnaOS-generated vendor makefile from adevtool.

PRODUCT_NAME := ana_shiba
PRODUCT_DEVICE := shiba
PRODUCT_MODEL := Pixel 8
PRODUCT_BRAND := Ana
PRODUCT_MANUFACTURER := AnaOS

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.anaos.device=shiba
