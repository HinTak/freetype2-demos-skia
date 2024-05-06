#!/bin/sh

pushd freetype2
  ./autogen.sh
  ./configure CC=clang++  CFLAGS='-fPIC -DPIC'
  make
popd
