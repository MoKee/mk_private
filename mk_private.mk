# Use all private apps
PRODUCT_PACKAGES += \
    Lawnchair \
    MoKeePay

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

ifeq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    LatinIME
else
ifeq ($(SMALL_BOARD_SYSTEMIMAGE_PARTITION),true)
PRODUCT_PACKAGES += \
    GooglePinYin
include vendor/mk/config/mk_audio_mini.mk
else
PRODUCT_PACKAGES += \
    GooglePinYin \
    GoogleIntl \
    vim
include vendor/mk/config/mk_audio.mk
endif
endif

# Disable dex-preopt of some devices to save space.
ifeq ($(SMALL_BOARD_SYSTEMIMAGE_PARTITION),true)
WITH_DEXPREOPT := false
endif

# Disable dex-preopt of some devices to fix compile.
ifneq ($(filter h811 h815 h830 h850,$(MK_BUILD)),)
WITH_DEXPREOPT := false
endif