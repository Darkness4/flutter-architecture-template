#!/bin/sh
flutter channel dev
flutter upgrade
flutter packages get
apt update
apt install -y lcov