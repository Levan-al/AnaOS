# AnaOS OFFICIAL_BUILD / updater wiring (TASK_016)
# Include from product makefiles when building release candidates.

ifeq ($(ANAOS_OFFICIAL_BUILD),true)
  PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
      ro.anaos.official=1 \
      ro.anaos.updater.uri=https://releases.anaos.org/ \
      ro.anaos.attestation.uri=https://attestation.anaos.org/ \
      ro.anaos.apps.uri=https://apps.anaos.org/

  # Fingerprint brand must stay AnaOS (never GrapheneOS / AOSP sample)
  # Concrete BUILD_ID / BUILD_NUMBER set by release scripts (TASK_017 / TASK_069).
endif

# Non-official / engineering builds must not claim release-keys channels.
ifneq ($(ANAOS_OFFICIAL_BUILD),true)
  PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
      ro.anaos.official=0
endif
