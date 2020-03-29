If you appreciate this project, support me on Patreon or Liberapay !

BTC : 16zwQUkG29D49G6C7pzch18HjfJqMXFNrW
Patreon : https://www.patreon.com/Miouyouyou
Liberapay : https://liberapay.com/Myy/donate

End of the project
------------------

This project (along with MyyQi) started a long time ago, in order to
get the various subsystems of RK3288 boards working on Mainline
kernels, with all the bells and whistles, with the hope of having a
Vulkan dev-board someday.  
So this project incorporated the Mali GPL kernel drivers, that had
to be used with the Mali Blobby GL drivers, which were updated by ARM
at the time, with the hope that ARM would release Vulkan drivers for
RK3288 boards !

Fast-forwarding 3 years later, mainline kernels now provide drivers
for the GPU, some staging drivers for the VPU (using V4L2 Request API,
which is rather unsupported...) and have incorporated various fixes
that make them *almost* useable without patches.  
Mesa now incorporates the OpenGL user-space drivers. There's still
some work to do on them but, still, they can run an entire batch of
glmark2 without major issues (just some weird drop shadows on one
test).

Meanwhile, neither ARM nor Rockchip have updated the  Mali user-space
drivers, making them unuseable with newer Mali kernel drivers.  
I tried to maintain the most recent version that worked with
the old blobby drivers, but it has reached a point where it's not
possible easily.  
So I'm dropping the whole Mali user-space drivers support.

That means that this repository purpose has reached its end.

You can now enjoy (almost) every feature of RK3288 boards
(except maybe Vulkan, unless someone wants to play with MESA) using
mainline kernels and standard MESA OpenGL drivers.  
The VPU part still requires a player able to handle V4L2 Request API
correctly. But that should come soon enough in every distribution.

So this repository only includes a few remaining patches for
Tinkerboard systems (as I'm pretty sure nobody uses MiQi boards
anymore), and that's it.

Using the main script
---------------------

```bash
bash GetPatchAndCompileKernel.sh
```

This works whether you cloned this whole repository or just downloaded
the script alone.

Don't hesitate to edit the script and replace the `CROSS_COMPILE` value
in the script, in order to match your cross-compiling toolset prefix.  
If you don't use cross-compile tools (meaning that you're compiling on
your ARMv7 machine), set it like this `CROSS_COMPILE=`

If you'd like to reconfigure the kernel using **menuconfig**, 
**nconfig**, **qtconfig**, ... do it like this :

```bash
# Assuming that you want to use menuconfig
MAKE_CONFIG=menuconfig bash GetPatchAndCompileKernel.sh
```

Now, you need all the tools required to compile a kernel.  
That includes, at least, `gcc`, `make`, `automake`,
`bison`, `flex`, `bc`, `pkg-config` and some SSL library
development headers (`libssl-dev` on Debian systems).

In order to use this script, you'll also need :
`wget`, `git` and `bash`.

Using `menuconfig` also require `ncurses` libraries and
development headers (`ncurses-dev` on Debian systems).

Prebuilt kernels
----------------

Armbian provide premade Debian packages of kernels for Rockchip systems
including most of the patches included here.

About
-----

This repository provides patches and mainline kernel cross-compiling
scripts tailored towards Rockchip 3288 boards.

The [main cross-compiling script](./GetPatchAndCompileKernel.sh) will :
* Clone the latest release or release candidate branch of the mainline kernel;
* Apply various RK3288 specific patches for Tinkerboard boards;
* Copy and use this repository configuration file;
* Cross-compile the patched kernel;
* Create the folder `/tmp/Rockmyy-Build` and install the cross-compiled kernel in that folder.

