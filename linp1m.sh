#!/bin/bash
echo "set env"
sudo bash ubuntu1604linuxmint18.sh
sudo bash install_android_sdk.bash
sudo bash create_user.sh
echo "Making Directory to sync lineage OS sources"
mkdir los
cd los
echo "Preparing to sync"
repo init -u git://github.com/LineageOS/android.git -b cm-14.1
repo sync -c -f --force-sync --no-clone-bundle --no-tags -j64
echo "Sync complete Syncing device repos"
git clone https://github.com/DhirajSurvase/android_device_lenovo_P1m device/lenovo/P1m
git clone https://github.com/DhirajSurvase/android_kernel_lenovo_P1m kernel/lenovo/P1m
git clone https://github.com/DhirajSurvase/android_vendor_lenovo_P1m vendor/lenovo/P1m
echo "Apply Patches"
cd device/lenovo/P1m/patches
sudo bash apply-patches.sh
cd ../../../..
. build/envsetup.sh
lunch "lineage_P1m-userdebug"
make bacon
