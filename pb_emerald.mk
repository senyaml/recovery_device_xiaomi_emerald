<a href="README.md" >Go Back</a>

### pb_device.mk sample

```bash
# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk) -- only for 64bit phones

# Inherit from device
$(call inherit-product, device/xiaomi/twrp_emerald.mk) -- path to main device makefile

# Inherit common product files.
$(call inherit-product, vendor/pb/config/common.mk)

# Set those variables here to overwrite the inherited values.
BOARD_VENDOR := mt6789
PRODUCT_BRAND := POCO
PRODUCT_DEVICE := emerald
PRODUCT_NAME := pb_emerald
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_MODEL := emerald
TARGET_VENDOR := emerald
```
