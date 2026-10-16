# AnaOS branding makefile fragment (injected by product makefiles)
# TASK_001 / TASK_014 / TASK_015

ANAOS_BRAND := Ana
ANAOS_MANUFACTURER := AnaOS
ANAOS_NAME := AnaOS
ANAOS_PACKAGE_PREFIX := org.anaos
ANAOS_COPYRIGHT := Copyright (C) The AnaOS Project

PRODUCT_BRAND := $(ANAOS_BRAND)
PRODUCT_MANUFACTURER := $(ANAOS_MANUFACTURER)

# Fingerprint uses AnaOS/<product>/<device>:... when OFFICIAL_BUILD is set.
# Concrete PRODUCT_NAME / PRODUCT_DEVICE / BUILD_ID are defined per device.
