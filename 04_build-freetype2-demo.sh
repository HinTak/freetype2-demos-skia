#!/bin/sh

pushd freetype2-demos
  make TOP_DIR=../freetype2
popd

# Test that it was successful
[ -f freetype2-demos/bin/ftgrid ]
