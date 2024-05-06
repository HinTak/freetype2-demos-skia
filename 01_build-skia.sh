#!/bin/sh

pushd skia-building-fun/
  ./download-and-build-skia.sh
popd

mkdir -p skia

pushd skia
  unzip ../skia-building-fun/skia-m125-bin.zip
popd
