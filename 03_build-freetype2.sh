#!/bin/sh

pushd freetype2
  ./autogen.sh
  ./configure CC=clang++  CFLAGS='-fPIC -DPIC'
  make
popd

# Test that it was successful
[ -f freetype2/objs/.libs/libfreetype.a ]
