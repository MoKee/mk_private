#
# Copyright (C) 2016 The MoKee Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := GoogleIntl
LOCAL_MODULE_TAGS := optional

LOCAL_MODULE_CLASS := APPS
LOCAL_BUILT_MODULE_STEM := package.apk
LOCAL_MODULE_SUFFIX := $(COMMON_ANDROID_PACKAGE_SUFFIX)
LOCAL_CERTIFICATE := PRESIGNED

ifeq ($(TARGET_ARCH),arm)
LOCAL_SRC_FILES := GoogleIntl-x32.apk
LOCAL_PREBUILT_JNI_LIBS := \
    lib/armeabi-v7a/libjni_keyboarddecoder.so \
    lib/armeabi-v7a/libjni_unbundled_latinimegoogle.so
else
LOCAL_SRC_FILES := GoogleIntl-x64.apk
LOCAL_PREBUILT_JNI_LIBS := \
    lib/arm64-v8a/libjni_keyboarddecoder.so \
    lib/arm64-v8a/libjni_unbundled_latinimegoogle.so
endif

include $(BUILD_PREBUILT)