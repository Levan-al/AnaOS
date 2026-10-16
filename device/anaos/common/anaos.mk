# AnaOS common product fragment (TASK_015)
# Include from device product makefiles.

PRODUCT_BRAND := Ana
PRODUCT_MANUFACTURER := AnaOS

# Branding injection
$(call inherit-product-if-exists, branding/config.mk)

PRODUCT_PACKAGES += \
    AnaOSUpdater \
    AnaOSAuditor \
    AnaOSCamera \
    AnaOSAppStore \
    AnaOSPdfViewer

# Official builds only talk to AnaOS update endpoints (TASK_016)
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.anaos.updater.uri=https://releases.anaos.org/ \
    ro.anaos.attestation.uri=https://attestation.anaos.org/
