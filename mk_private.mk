# Use all private apps
ifneq ($(filter kingdom v500,$(MK_BUILD)),)
PRODUCT_PACKAGES += \
    MoKeePay
else
PRODUCT_PACKAGES += \
    MoKeePay \
    Turbo
endif

# Use all private binaries
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/private/mokee/bin/$(MK_CPU_ABI),system/bin)

# Use all private libraries
ifeq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/mokee/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/private/mokee/lib/armeabi-v7a,system/lib)
else
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/mokee/lib/$(MK_CPU_ABI),system/lib)
endif

# Offline phone location database
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,mokee-phonelocation.dat,vendor/private/mokee/common/media/location,system/media/location)

ifneq ($(filter armani condor deb dior falcon flo i9100 mako maserati spyder targa tomato umts_spyder,$(MK_BUILD)),)
SMALL_BOARD_SYSTEMIMAGE_PARTITION := true
TARGET_BOOTANIMATION_HALF_RES := true
endif

# Default input method and Jelly apps
ifeq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    Jelly \
    LatinIME
else
ifeq ($(SMALL_BOARD_SYSTEMIMAGE_PARTITION),true)
PRODUCT_PACKAGES += \
    Jelly \
    GooglePinYin
# Include MK audio files
include vendor/mk/config/mk_audio_mini.mk
else
PRODUCT_PACKAGES += \
    YuBrowser \
    GooglePinYin \
    GoogleIntl \
    vim
# Include MK audio files
include vendor/mk/config/mk_audio.mk
endif
endif

# Disable dex-preopt of some devices to save space.
ifeq ($(SMALL_BOARD_SYSTEMIMAGE_PARTITION),true)
WITH_DEXPREOPT := false
endif

# Disable dex-preopt of some devices to fix compile.
ifneq ($(filter h811 h815,$(MK_BUILD)),)
WITH_DEXPREOPT := false
endif

# Default sound effects app
PRODUCT_PACKAGES += \
    AudioFX

# V4a modules
# ifeq ($(filter armeabi armeabi-v7a x86,$(MK_CPU_ABI)),)
# PRODUCT_PACKAGES += \
#     AudioFX
# else
# ifneq ($(filter shamu victara victara_retcn, $(MK_BUILD)),)
# PRODUCT_PACKAGES += \
#     AudioFX
# else
# PRODUCT_PACKAGES += \
#     ViPER4Android
# endif
# PRODUCT_COPY_FILES += \
#     $(call find-copy-subdir-files,*.so,vendor/private/viper/lib/$(MK_CPU_ABI),system/lib)
# endif
