#!/bin/sh

pushd svg-native-viewer/svgnative/
  cmake -Bbuild/linux -H. -DSHARED=ON -DLIB_ONLY=ON -DPLATFORM_XML=ON -DCAIRO=ON \
  -DSKIA=ON -DSKIA_LIBRARY_PATH=`pwd`/../../skia/out/Shared/libskia.so \
  -DSKIA_SOURCE_DIR=`pwd`/../../skia/ -DCMAKE_CXX_FLAGS="-I`pwd`/include/svgnative/" \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON -DCMAKE_CXX_COMPILER=/usr/bin/clang++
  pushd build/linux/
    make
  popd
popd

# For relocating/copying result elsewhere, this might be needed:
# (This command also double as a test that compilation was successful)
chrpath -d svg-native-viewer/svgnative/build/linux/libSVGNativeViewerLib.so
