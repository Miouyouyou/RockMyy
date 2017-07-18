If you appreciate this project, support me on Patreon !

[![Patreon !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-patreon.png)](https://www.patreon.com/Miouyouyou)

Prebuilt kernels
----------------

If you're looking for prebuilt RK3288 kernels for MiQi, Tinkerboard,
Firefly boards and various RK3288 boards supported by mainline kernels,
see [RockMyy-Build](https://github.com/Miouyouyou/RockMyy-Build).

Armbian provide premade Debian packages of kernels for Rockchip systems
including most of the patches included here.

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


