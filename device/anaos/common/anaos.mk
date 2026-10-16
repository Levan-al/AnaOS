# AnaOS common product fragment (TASK_015)
# Include from device product makefiles.

PRODUCT_BRAND := Ana
PRODUCT_MANUFACTURER := AnaOS

# Branding injection
$(call inherit-product-if-exists, branding/config.mk)

$(call inherit-product-if-exists, device/anaos/common/official.mk)

PRODUCT_PACKAGES += \
    AnaOSUpdater \
    AnaOSAuditor \
    AnaOSCamera \
    AnaOSAppStore \
    AnaOSPdfViewer \
    AnaOSSetupWizard

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.anaos.version=dev \
    ro.anaos.brand=Ana

# Property catalog: docs/PRODUCT_PROPERTIES.md
