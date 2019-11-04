#!/bin/sh
SCRIPTPATH=$(dirname "$(realpath "$0")")
emulator -avd test -no-window -no-audio &
/bin/bash "$SCRIPTPATH/android-wait-for-emulator"
adb shell input keyevent 82
adb devices
