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
ifneq ($(filter armeabi armeabi-v7a arm64-v8a,$(MK_CPU_ABI)),)
GAPPS_ROOT_PATH := vendor/private/google
ifeq ($(MK_CPU_ABI),arm64-v8a)
$(shell $(foreach app, $(shell ls $(GAPPS_ROOT_PATH)),mkdir -p out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm64; \
    $(foreach lib, $(shell test -d $(GAPPS_ROOT_PATH)/$(app)/$(MK_CPU_ABI)/lib64 && ls $(GAPPS_ROOT_PATH)/$(app)/$(MK_CPU_ABI)/lib64),ln -sf /system/lib64/$(lib) out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm64/$(lib);)))
else
$(shell $(foreach app, $(shell ls $(GAPPS_ROOT_PATH)),mkdir -p out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm; \
    $(foreach lib, $(shell test -d $(GAPPS_ROOT_PATH)/$(app)/$(MK_CPU_ABI)/lib && ls $(GAPPS_ROOT_PATH)/$(app)/$(MK_CPU_ABI)/lib),ln -sf /system/lib/$(lib) out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm/$(lib);)))
endif
PRODUCT_COPY_FILES += \
    $(foreach app, $(shell ls $(GAPPS_ROOT_PATH)),$(call find-copy-subdir-files,*.apk,$(GAPPS_ROOT_PATH)/$(app)/$(MK_CPU_ABI),system/app/$(app))) \
    $(foreach app, $(shell ls $(GAPPS_ROOT_PATH)),$(call find-copy-subdir-files,*.so,$(GAPPS_ROOT_PATH)/$(app)/$(MK_CPU_ABI),system))
else
PRODUCT_PACKAGES += \
    LatinIME
endif

# V4a modules
ifneq ($(MK_CPU_ABI),arm64-v8a)
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.so,vendor/private/viper/lib/$(MK_CPU_ABI)/soundfx,system/lib/soundfx)
endif