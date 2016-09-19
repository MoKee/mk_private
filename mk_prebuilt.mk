# Use all private apps
PRODUCT_PACKAGES += \
    AMapNetworkLocation \
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

# Google and Browser2 apps
ifeq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    Browser2 \
    LatinIME
else
ifneq ($(filter armani cancro dior i9100 tomato, $(MK_BUILD)),)
PRODUCT_PACKAGES += \
    Browser2 \
    GoogleIntl \
    GooglePinYin
else
PRODUCT_PACKAGES += \
    YuBrowser \
    GoogleIntl \
    GooglePinYin
endif
endif

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

# Disable dex-preopt of some devices to save space, if requested.
# ifneq ($(filter cancro i9100 umts_spyder spyder maserati targa, $(MK_BUILD)),)
# WITH_DEXPREOPT := false
# endif