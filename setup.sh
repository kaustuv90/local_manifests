#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/lineage/build/envsetup.sh";

# hardware/qcom-caf/sm8450/audio/pal
changes=(
419838 # PayloadBuilder: Populate key vector for ultrasound RX
424480 # WIP implement ultrasound rampdown support
425541 # Implement speaker protection profiles
#417192 # WIP add support for awinic speaker
)
repopick -f -P hardware/qcom-caf/sm8450/audio/pal ${changes[@]}&

# hardware/qcom-caf/sm8450/audio/primary-hal
changes=(
419581 # hal: Add ultrasound proximity support
)
repopick -f -P hardware/qcom-caf/sm8450/audio/primary-hal ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"
cd ../../..
