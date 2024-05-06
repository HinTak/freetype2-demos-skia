This is a patch to build ft2demos to use skia + its built-in svg parser, or svg-native-viewer + cairo or skia, to render ot-svg, in addition to the current,
which is via rsvg + cairo (which has some bugs). Earlier version posted on [harfbuzz-python-demos](https://github.com/HinTak/harfbuzz-python-demos).

Documentation is a bit sparse (definitely missing a "requirement" section - read the CI yaml for what is needed),
and the build scripts needs to be updated to fail properly on CI [issue 1](https://github.com/HinTak/freetype2-demos-skia/issues/1).

The `Makefile` part of the patch has some harmless bits which is part of another add-on for COLRv1 I am too lazy to remove.
(and is part of what I have myself [binary-archive](https://github.com/FontVal-extras/binary-archive/),
Fontval-enhanced freetype + ot-svg & COLRv1 -enhanced ft2demos).

It takes about 20 minutes, and under 1GB disk space on CI. 90% (18 minutes) on building skia, both static and shared versions
(only shared is used here; static version is used by skia-python). Most of the disk space requirement is from svg-native-viewer's
submodule dependencies. (skia requires about 300MB).

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

# Requirement

TODO - Please read the CI yaml for now... you need to be able to build Skia, Adobe's svg-native-viewer, and freetype2-demos separately.

* Skia itself requires Google's build tool `ninji` mainly, and many graphics-related libaries.

* Adobe's svg-native-viewer requires `cmake`

* Freetype requires `autoconf`, `automake`, `libtool`, `diffutils`

* Putting all of them together, requires cairo and librsvg2 development files.

# Relevant Bug-Filings

Skia recommends using `clang`, although `gcc` works: [clang-18: -ffat-lto-objects gives multiple definition of `.str.llvm.0'](https://bugzilla.redhat.com/show_bug.cgi?id=2279170) .

Skia: [symbol usage across modules](https://issues.skia.org/issues/40045538),
[skunicode module's recent 'Reland "Fix defines for icu_subset"' commit in m125 broke skia_use_system_icu=true usage](https://issues.skia.org/338570715)

Adobe's svg-native-viewer: Pulls [Skia m122 core support](https://github.com/adobe/svg-native-viewer/pull/199),
[Misc linux clang build error fix](https://github.com/adobe/svg-native-viewer/pull/198),
[Fixes Cairo-enabled build breakage from "Add C++17 compatibility in](https://github.com/adobe/svg-native-viewer/pull/196).
Issues:
[Misc missing headers build errors](https://github.com/adobe/svg-native-viewer/issues/197),
[Cairo build breakage from recent c++17 change](https://github.com/adobe/svg-native-viewer/issues/195),
[A few compatibility issues with recent cairo](https://github.com/adobe/svg-native-viewer/issues/188),
[A few compatibility issues with skia m110](https://github.com/adobe/svg-native-viewer/issues/187),
[Missing <cstdint> in svgnative/SVGRenderer.h](https://github.com/adobe/svg-native-viewer/issues/186),
[This svg from google fonts gets mis-rendered.](https://github.com/adobe/svg-native-viewer/issues/185).

