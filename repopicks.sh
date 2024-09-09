#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/infinity/build/envsetup.sh";

# device/qcom/sepolicy_vndr/sm8450
changes=(
398452 # sepolicy_vndr: Label proc firmware config node
398453 # sepolicy_vndr: Allow init/vendor_init to write proc firmware config
)
repopick -g https://review.lineageos.org -P device/qcom/sepolicy_vndr/sm8450 ${changes[@]}&

# hardware/xiaomi
changes=(
392967 # sensors: Let the reading of poll fd be configurable
392969 # sensors: sensors: Implement udfps long press sensor
393396 # sensors: Implement single tap sensor
393397 # sensors: Implement double tap sensor
399848 # Rewrite IR HAL in AIDL
400391 # ir: Stop setting duty cycle
)
repopick -g https://review.lineageos.org -P hardware/xiaomi ${changes[@]}&

# vendor/lineage
changes=(
367044 # android: merge_dtbs: Respect miboard-id while merging
393422 # config: Add common config for book-style foldables
)
repopick -g https://review.lineageos.org -P vendor/lineage ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"
cd ../../..
