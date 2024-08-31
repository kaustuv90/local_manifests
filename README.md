<p align="center">
<img src="https://github.com/RisingTechOSS/android/blob/fourteen/risingOS_banner.png">
</p>

What is RisingOS?
---------------
risingOS is a OpenSource Aftermarket Android Operating System that aims to bring unique and fresh user experience.

Base Firmware
---------------
[**crDroid Android**](https://github.com/crdroidandroid)

Maintainership
---------------
We're short in manpower right now (core members are busy with maintaining source and can't review applicants). Maintainership is closed until source workload is low.
 
Getting Started
---------------
**Initialize local repository**
```bash
repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs
```



**Let's sync zeus/dagda specific trees:**
```bash
git clone https://github.com/kaustuv90/local_manifests.git -b rising-14 .repo/local_manifests
```




**Sync up with this command:**
```bash
repo sync -c --no-clone-bundle --optimized-fetch --prune --force-sync -j$(nproc --all)
```

```bash
# For gms or chromium blobs related errors due to git lfs (gitlab now limits files up to 100mb max) (credits to haggertk):
sudo apt install git-lfs
git lfs install

rm -rf vendor/gms
rm -rf .repo/projects/vendor/gms.git
rm -rf .repo/project-objects/*/android_vendor_gms.git

repo init -u https://github.com/RisingTechOSS/android -b fourteen --git-lfs

# for SSH
repo init -u git@github.com:RisingTechOSS/android.git -b fourteen --git-lfs 

```

Preparing device for building risingOS
---------------
**Inherit LineageOS Vendor stuffs**
```bash
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)
```

Building Flags
---------------
```bash
# friendly tip: builders can use vendor init_xxx.cpp as workaround for spacing
# e.g. property_override("ro.rising.chipset", "Snapdragon 870 5G");
RISING_CHIPSET="Google Tensor 2"

# friendly tip: builders can use vendor init_xxx.cpp as workaround for spacing
# e.g. property_override("ro.rising.maintainer", "maintainer");
RISING_MAINTAINER="Niv"

#In rising_<device>.mk Add the following properties to `PRODUCT_BUILD_PROP_OVERRIDES`

example:
PRODUCT_BUILD_PROP_OVERRIDES += \
    RISING_CHIPSET="Google Tensor 2" \
    RISING_MAINTAINER="Niv"

# chipset flag enclose var with "" if more than one
# this will reflect on build/display version, a firmware package/zip name 
# e.g. risingOS-2.1-COMMUNITY-device-AOSP.zip - AOSP is the default package type, WITH_GMS will override the package type to PIXEL
RISING_PACKAGE_TYPE := "VANILLA_AOSP"

# disable/enable blur support, default is false
TARGET_ENABLE_BLUR := true/false

# whether to ship aperture camera, default is false
PRODUCT_NO_CAMERA := true/false

# Wether to ship lawnchair launcher
TARGET_PREBUILT_LAWNCHAIR_LAUNCHER := true/false 
```

GMS Flags
---------------
```bash
# GMS build flags
# ship with GMS packages, replaces default AOSP packages with Google manufactured packages.
WITH_GMS := true/false

# These flags needs WITH_GMS set to true
# for more information about core GMS flags, please see vendor/gms/common/common-vendor.mk
# ships core GMS components that are needed to run GMS environment
TARGET_CORE_GMS := true/false

# extra add-ons for core GMS builds
# List of add-ons
# PRODUCT_PACKAGES += \
#    Photos \
#    MarkupGoogle \
#    LatinIMEGooglePrebuilt \
#    AiWallpapers \
#    WallpaperEmojiPrebuilt \
#    PrebuiltDeskClockGoogle \
#    CalculatorGooglePrebuilt \
#    CalendarGooglePrebuilt \
#    Velvet
TARGET_CORE_GMS_EXTRAS := true/false

# on the other hand builders can build customize packages by simply defining product packages
# instead of defining TARGET_CORE_GMS_EXTRAS
# PRODUCT_PACKAGES += \
#    add package name here e.g: Velvet \
#    LatinIMEGooglePrebuilt (if builder prefers gboard)

# Wether to ship pixel launcher and set it as default launcher
TARGET_DEFAULT_PIXEL_LAUNCHER := true/false 

# Android System Intelligence (Pixels devices)
It is recommended for Builders to drop other versions of DevicePersonalization except for DevicePersonalization2020 to avoid breakages on pixel features like Live Captions/NGA etc.
```

Building the firmware
---------------
**Setting up environment**
```bash
. build/envsetup.sh
```
**riseup uses all available cores to assign jobs hence making -jX no-op, to utilize -jX use:**
```bash
riseup <device> <build-type> 
```
```bash
rise b
```

**Building fastboot update package**
```bash
riseup <device> <build-type> 
```
```bash
rise fb
```

**Signed build(Replacing testkey with releasekey for play integrity, certification etc.)**
```bash
riseup <device> <build-type> 
```
```bash
# Perform manual key generation
# 'gk' will include keys from vendor/lineage-priv/keys
# after generating keys
gk -s

# For more info about gk (generate keys)
gk -h/--help

# Build the firmware with the preferred method except for 'rise sb'
rise/rise b/mka bacon etc.
```

**Building fully signed ota package**
```bash
riseup <device> <build-type> 
```
```bash
# 'rise sb' is an attempt to automate LineageOS builds signing.
# Reference: https://wiki.lineageos.org/signing_builds
# In case of errors or any other difficulties, avoid using 'rise sb'
# If the builder wants to simply replace the testkey certificate with the releasekey
# Please refer to 'Replacing testkey with releasekey'
# (Automatic generation of keys will be performed if keys do not exist).
# For manual key generation, please use "gk":
gk -f (to regenerate replace old keys, rise sb automatically generate keys for full build signing if no keys exists)
rise sb
```

**Opting out of signed builds**
```bash
riseup <device> <build-type> 
```
```bash
remove_keys # This will remove generated keys so the system will revert back to test keys.
```

**For more information about the rise build command:**
```bash
rise help
```

Bug Reports/Issue Tracker
---------------
[**Issue Tracker**](https://github.com/RisingTechOSS/issue_tracker)

Contributions/Translations
---------------
Contributions/Translations are always welcome! Please feel free to do pull requests!

Pull requests will be reviewed by source maintainers and will be merged/added to work-in-progress repositories once changes are verified.


Credits
---------------
* [**AOSPA**](https://github.com/AOSPA)
* [**AICP**](https://github.com/AICP)
* [**Bootleggers**](https://github.com/BootleggersROM)
* [**crDroid**](https://github.com/crdroidandroid)
* [**Corvus-AOSP**](https://github.com/Corvus-R)
* [**Derpfest**](https://github.com/Derpfest-12)
* [**DotOS**](https://github.com/DotOS)
* [**Evolution-X**](https://github.com/Evolution-X)
* [**Flamingo-OS**](https://github.com/Flamingo-OS)
* [**LineageOS**](https://github.com/LineageOS)
* [**Octavi-OS**](https://github.com/Octavi-OS)
* [**Omnirom**](https://github.com/omnirom)
* [**PixelDust Caf**](https://github.com/pixeldust-project-caf)
* [**Project-Fluid**](https://github.com/Project-Fluid)
* [**Project Kaleidoscope**](https://github.com/Project-Kaleidoscope)
* [**Project Radiant**](https://github.com/ProjectRadiant)
* **RiceDroid**
* [**SparkOS**](https://github.com/Spark-Rom)
* [**StagOS**](https://github.com/StagOS)
* [**Xdroid-OSS**](https://github.com/xdroid-oss)

