#!/bin/sh
flutter channel dev
flutter upgrade
flutter packages get
flutter pub upgrade
apt update
apt install -y bash sed libpulse-dev git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip
sdkmanager "emulator" "system-images;android-29;default;x86"
yes | sdkmanager --licenses
sdkmanager --update
yes | sdkmanager --licenses
echo no | avdmanager create avd --force -n test -k "system-images;android-29;default;x86" --abi "x86" --device "Galaxy Nexus" 
yes | sdkmanager --licenses
sdkmanager --list | sed -e '/Available Packages/q'
flutter doctor -v
