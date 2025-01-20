#!/bin/bash
set -e

source "build/envsetup.sh";
source "vendor/lineage/build/envsetup.sh";

# vendor/lineage
changes=(
367044 # android: merge_dtbs: Respect miboard-id while merging
)
repopick -P vendor/lineage ${changes[@]}&

wait

# Build kernel with KernelSU from main branch
cd kernel/xiaomi/sm8450
curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -s main
git add --all
git commit -m "Build kernel with KernelSU from main branch"
cd ../../..
