#!/bin/sh
apt update
apt upgrade -y
flutter upgrade
flutter clean
flutter pub get upgrade