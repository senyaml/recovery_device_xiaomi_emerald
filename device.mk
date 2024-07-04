# Copyright (C) 2024 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# V A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Bootctrl
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.1-mtkimpl \
    android.hardware.boot@1.0-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    android.hardware.boot@1.1-mtkimpl.recovery \
    android.hardware.boot@1.0-mtkimpl.recovery \
    bootctrl

#PRODUCT_PACKAGES_DEBUG += \
 #   bootctrl

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock \
    android.hardware.fastboot@1.1-impl-mock

# Health Hal
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service
    
# AB
AB_OTA_UPDATER := true

# A/B
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot
    
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 32

# API
PRODUCT_SHIPPING_API_LEVEL := 32

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# MTK PlPath Utils
PRODUCT_PACKAGES += \
    mtk_plpath_utils.recovery

# Keystore Hal
PRODUCT_PACKAGES += \
    android.system.keystore2

# Security
PRODUCT_PACKAGES += \
    android.hardware.security.keymint \
    android.hardware.security.secureclock \
    android.hardware.security.sharedsecret

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libion \
    libpuresoftkeymasterdevice \
    

# Keymaster
PRODUCT_PACKAGES += \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.0.so

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V1-ndk_platform.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/vendor.hardware.vibratorfeature.IVibratorExt-V1-ndk_platform.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.keymaster@4.0

TW_LOAD_VENDOR_MODULES := "flashlight.ko ft3683g.ko flashlights-mt6789.ko xiaomi.ko haptic.ko fshaptic_o.ko"

TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.keymaster@4.0 \
    android.hardware.keymaster@4.0.so

