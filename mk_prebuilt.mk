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
ifeq ($(MK_CPU_ABI),arm64-v8a)
STUB := $(shell mkdir -p out/target/product/$(MK_BUILD)/system/app/GoogleIntl/lib/arm64; \
    ln -sf /system/lib64/libjni_keyboarddecoder.so out/target/product/$(MK_BUILD)/system/app/GoogleIntl/lib/arm64/libjni_keyboarddecoder.so; \
    ln -sf /system/lib64/libjni_unbundled_latinimegoogle.so out/target/product/$(MK_BUILD)/system/app/GoogleIntl/lib/arm64/libjni_unbundled_latinimegoogle.so; \
    mkdir -p out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64; \
    ln -sf /system/lib64/liben_data_bundle.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/liben_data_bundle.so; \
    ln -sf /system/lib64/libgnustl_shared.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libgnustl_shared.so; \
    ln -sf /system/lib64/libhwr.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libhwr.so; \
    ln -sf /system/lib64/libhwrword.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libhwrword.so; \
    ln -sf /system/lib64/libhwrzhmodel.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libhwrzhmodel.so; \
    ln -sf /system/lib64/libjni_gesture_engine.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libjni_gesture_engine.so; \
    ln -sf /system/lib64/libjni_hmm_shared_engine.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libjni_hmm_shared_engine.so; \
    ln -sf /system/lib64/libpinyin_data_bundle.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm64/libpinyin_data_bundle.so;)
else
STUB := $(shell mkdir -p out/target/product/$(MK_BUILD)/system/app/GoogleIntl/lib/arm; \
    ln -sf /system/lib/libjni_keyboarddecoder.so out/target/product/$(MK_BUILD)/system/app/GoogleIntl/lib/arm/libjni_keyboarddecoder.so; \
    ln -sf /system/lib/libjni_unbundled_latinimegoogle.so out/target/product/$(MK_BUILD)/system/app/GoogleIntl/lib/arm/libjni_unbundled_latinimegoogle.so; \
    mkdir -p out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm; \
    ln -sf /system/lib/liben_data_bundle.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/liben_data_bundle.so; \
    ln -sf /system/lib/libgnustl_shared.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libgnustl_shared.so; \
    ln -sf /system/lib/libhwr.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libhwr.so; \
    ln -sf /system/lib/libhwrword.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libhwrword.so; \
    ln -sf /system/lib/libhwrzhmodel.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libhwrzhmodel.so; \
    ln -sf /system/lib/libjni_gesture_engine.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libjni_gesture_engine.so; \
    ln -sf /system/lib/libjni_hmm_shared_engine.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libjni_hmm_shared_engine.so; \
    ln -sf /system/lib/libpinyin_data_bundle.so out/target/product/$(MK_BUILD)/system/app/GooglePinYin/lib/arm/libpinyin_data_bundle.so;)
endif

PRODUCT_COPY_FILES += \
    $(call find-copy-subdir-files,*.apk,vendor/private/google/GooglePinYin/$(MK_CPU_ABI),system/app/GooglePinYin) \
    $(call find-copy-subdir-files,*.so,vendor/private/google/GooglePinYin/$(MK_CPU_ABI),system) \
    $(call find-copy-subdir-files,*.apk,vendor/private/google/GoogleIntl/$(MK_CPU_ABI),system/app/GoogleIntl) \
    $(call find-copy-subdir-files,*.so,vendor/private/google/GoogleIntl/$(MK_CPU_ABI),system)