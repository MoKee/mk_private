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

# Google apps
ifeq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
PRODUCT_PACKAGES += \
    Browser \
    LatinIME
else
PRODUCT_PACKAGES += \
    Chromium \
    GoogleIntl \
    GooglePinYin
endif

# V4a modules
ifneq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/viper/lib/$(MK_CPU_ABI),system/lib)
endif