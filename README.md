If you appreciate this project, support me through Patreon or Pledgie !

[![Pledgie !](https://pledgie.com/campaigns/32702.png)](https://pledgie.com/campaigns/32702)
[![Patreon !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-patreon.png)](https://www.patreon.com/Miouyouyou)

About this branch
-----------------

This branch includes patches required by the
[**retry** branch of my **rockchip-vcodec** repository](https://github.com/Miouyouyou/rockchip-vcodec/tree/retry).
rockchip-vcodec being where I'm patching the VPU driver to make it work
on 4.13 kernels.

A few tests seem to indicate that everything works great now. Basically,
playing the right 1080p WebM and MP4 samples with
[**MPV**, using **MPP** and its libraries as a backend](https://github.com/LongChair/mpv),
works great !
However, more tests need to be done and that's where this branch is
useful.

MPV was tested using the Mali wayland-aware user-space binary drivers for
Firefly systems, and the DRM interface of course.
The command was :
LD_LIBRARY_PATH=/path/to/mali/drivers/wayland mpv --vo drm --hwdec rkmpp /tmp/0007_16_blocks_vp8_1080p_12mbps.webm

`/path/to/mali/drivers/wayland` being the path including the Mali
Midgard r12p0 user-space binary drivers for Firefly systems.
[These drivers can be obtained through ARM Mali webpage](https://developer.arm.com/products/software/mali-drivers/user-space).

[A related branch has been created on **RockMyy-Build**](https://github.com/Miouyouyou/RockMyy-Build/tree/VPU_Work_tests)
in order to get ready-made kernel builds in order to test the VPU code
directly, without having to recompile kernels and drivers and such...

Using the main script
---------------------

```bash
sh GetPatchAndCompileKernel.sh
```

This works whether you cloned this whole repository or just downloaded
the script alone.

Don't hesitate to edit the script and replace the `CROSS_COMPILE` value
in the script, in order to match your cross-compiling toolset prefix.

If you'd like to reconfigure the kernel using **menuconfig**, 
**nconfig**, **qtconfig**, ... do it like this :

```bash
# Assuming that you want to use menuconfig
MAKE_CONFIG=menuconfig sh GetPatchAndCompileKernel.sh
```

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

