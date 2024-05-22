#!/bin/sh

pushd skia-building-fun/
  ./download-and-build-skia.sh
popd

mkdir -p skia

pushd skia
  unzip ../skia-building-fun/skia-m1[0-9][0-9]-bin.zip
popd

# Test that it was successful
[ -f skia/out/Shared/libskia.so ]
