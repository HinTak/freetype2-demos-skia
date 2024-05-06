#!/bin/sh

pushd freetype2
  ./autogen.sh
  ./configure CC=clang++
  make
popd
