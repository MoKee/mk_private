# Use all private apps
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/private/priv-app/,system/priv-app)

# Use all private binaries
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*,vendor/private/bin/$(MK_CPU_ABI),system/bin)

# Use all private libraries
ifeq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/lib/$(MK_CPU_ABI),system/lib64) \
    $(call find-copy-subdir-files,*.so,vendor/private/lib/armeabi-v7a,system/lib)
else
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/lib/$(MK_CPU_ABI),system/lib)
endif

# Offline phone location database
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,mokee-phonelocation.dat,vendor/private/common/media/location,system/media/location)

# Google and Browser apps
ifeq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    Browser \
    LatinIME
else
ifneq ($(filter i9100, $(MK_BUILD)),)
PRODUCT_PACKAGES += \
    Browser \
    GoogleIntl \
    GooglePinYin
else
PRODUCT_PACKAGES += \
    Chromium \
    GoogleIntl \
    GooglePinYin
endif
endif

# V4a modules
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/viper/lib/$(MK_CPU_ABI),system/lib)
ifeq ($(filter armeabi armeabi-v7a x86,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    AudioFX
else
ifneq ($(filter shamu victara victara_retcn, $(MK_BUILD)),)
PRODUCT_PACKAGES += \
    AudioFX
else
PRODUCT_PACKAGES += \
    ViPER4Android
endif
endif