#!/bin/sh

FILES=./test_driver/screenshots/*.png
for f in $FILES
do
  echo "Processing $f file..."
  convert -resize 25% $f $f
done
