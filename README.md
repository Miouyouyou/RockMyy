If you appreciate this project, support me on Patreon !

[![Patreon !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-patreon.png)](https://www.patreon.com/Miouyouyou)

Warning
-------

**THIS IS THE TINKERING BRANCH, RESERVED FOR SPECIAL (POSSIBLY BROKEN) PATCHES FOR TINKERBOARDS**

If you're there for standard kernel builds, usable on Tinkerboards, use
the [master branch](https://github.com/Miouyouyou/RockMyy)

Prebuilt kernels
----------------

There are no builds for this branch, currently.

About
-----

This repository provides patches and mainline kernel cross-compiling
scripts tailored towards Rockchip 3288 boards.

The [main cross-compiling script](./GetPatchAndCompileKernel.sh) will :
* Clone the latest release or release candidate branch of the mainline kernel;
* Integrate the Mali Midgard r19p0 drivers to the cloned kernel;
* Apply various RK3288 specific patches for MiQi, Tinkerboard and Firefly boards;
* Copy and use this repository configuration file;
* Cross-compile the patched kernel;
* Create the folder /tmp/Rockmyy-Build and install the cross-compiled kernel in that folder.


