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

# Offline Phone Location Database
PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,mokee-phonelocation.dat,vendor/private/common/media/location,system/media/location)

# Google apps
GAPPS_PATH := vendor/private/google
ifeq ($(MK_CPU_ABI),arm64-v8a)
STUB := $(shell $(foreach app, $(shell ls $(GAPPS_PATH)),mkdir -p out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm64; \
    $(foreach lib, $(shell ls $(GAPPS_PATH)/$(app)/$(MK_CPU_ABI)/lib64),ln -sf /system/lib64/$(lib) out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm64/$(lib);)))
else
STUB := $(shell $(foreach app, $(shell ls $(GAPPS_PATH)),mkdir -p out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm; \
    $(foreach lib, $(shell ls $(GAPPS_PATH)/$(app)/$(MK_CPU_ABI)/lib),ln -sf /system/lib/$(lib) out/target/product/$(MK_BUILD)/system/app/$(app)/lib/arm/$(lib);)))
endif

PRODUCT_COPY_FILES += \
    $(foreach app, $(shell ls $(GAPPS_PATH)),$(call find-copy-subdir-files,*.apk,$(GAPPS_PATH)/$(app)/$(MK_CPU_ABI),system/app/$(app))) \
    $(foreach app, $(shell ls $(GAPPS_PATH)),$(call find-copy-subdir-files,*.so,$(GAPPS_PATH)/$(app)/$(MK_CPU_ABI),system))
