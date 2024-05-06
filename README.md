To start with, (svg-native-viewer requires `--recursive`)

```
git submodule update --init --recursive
```

Then just running the scripts one after the other:
```
./00_apply-patches.sh
./01_build-skia.sh
./02_build-svg-native-viewer.sh
./03_build-freetype2.sh
./04_build-freetype2-demo.sh
```

There is a "-s <N>" switch for both ftview and ftgrid to use skia
at launch time, instead of rsvg. It is not possible to dynamically
re-render without restart. Limited by current design.

