# Copyright (C) 2024 The Android Open Source Project
# SPDX-License-Identifier: Apache-2.0

# Inherit from common AOSP config
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Enable project quotas and casefolding for emulated storage without sdcardfs
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Installs gsi keys into ramdisk, to boot a GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure twrp common.mk
$(call inherit-product, vendor/twrp/config/common.mk)

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# V A/B
ENABLE_VIRTUAL_AB := true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Bootctrl
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl

PRODUCT_PACKAGES_DEBUG += \
    bootctrl

# Fastbootd
PRODUCT_PACKAGES += \
    fastbootd \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd
	
# Health Hal
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service
    
# AB
AB_OTA_UPDATER := true
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

# A/B
AB_OTA_PARTITIONS += \
    apusys \
    audio_dsp \
    boot \
    ccu \
    dpm \
    dtbo \
    gpueb \
    gz \
    lk \
    logo \
    mcf_ota \
    mcupm \
    md1img \
    mvpu_algo \
    odm \
    odm_dlkm \
    pi_img \
    preloader_raw \
    product \
    scp \
    spmfw \
    sspm \
    system \
    system_ext \
    tee \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vcp \
    vendor \
    vendor_boot \
    vendor_dlkm \
    mi_ext
    
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# VNDK
PRODUCT_TARGET_VNDK_VERSION := 33

# API
PRODUCT_SHIPPING_API_LEVEL := 31

PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# MTK plpath utils
PRODUCT_PACKAGES += \
    mtk_plpath_utils \
    mtk_plpath_utils.recovery

# Drm
PRODUCT_PACKAGES += \
    android.hardware.drm@1.4

# Additional configs
TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.graphics.common@1.0.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libxml2.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libion.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/android.hardware.vibrator-V1-ndk_platform.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/vendor.hardware.vibratorfeature.IVibratorExt-V1-ndk_platform.so \
	
    
TARGET_RECOVERY_DEVICE_MODULES += \
    android.hardware.graphics.common@1.0 \
    libion \
    libxml2 \
    android.hardware.vibratorfeature \

    #hidl
    PRODUCT_ENFORCE_VINTF_MANIFEST += true

    #namepcas
    PRODUCT_SONG_NAMESPACES += $(DEVICE_PATH)


