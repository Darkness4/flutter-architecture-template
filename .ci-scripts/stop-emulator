#!/usr/bin/env bash

for ((PORT=5554; PORT<=5584; PORT+=2)); do
    echo killing emulator-$PORT...
    adb -s emulator-$PORT emu kill || true
done
