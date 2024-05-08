#!/bin/sh

pushd svg-native-viewer
  patch -p1 < ../svg-native-viewer.diff
popd

#pushd freetype2
#  patch -p1 < ../freetype2.diff
#popd

pushd freetype2-demos
  patch -p1 < ../freetype2-demos-4-svg-hooks-skia.patch
popd
