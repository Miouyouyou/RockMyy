If you appreciate this project, support me on Patreon or Liberapay !

[![Patreon !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-patreon.png)](https://www.patreon.com/Miouyouyou) 
[![Liberapay !](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/button-liberapay.png)](https://liberapay.com/Myy/donate) 
[![Tip with Altcoins](https://raw.githubusercontent.com/Miouyouyou/Shapeshift-Tip-button/9e13666e9d0ecc68982fdfdf3625cd24dd2fb789/Tip-with-altcoin.png)](https://shapeshift.io/shifty.html?destination=16zwQUkG29D49G6C7pzch18HjfJqMXFNrW&output=BTC)
[![Gimme Bitcoins](https://raw.githubusercontent.com/Miouyouyou/RockMyy/master/.img/bitcoin.png)](./.img/bitcoin-qrcode.png)

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
That includes, at least, `gcc`, `make`, `automake`, `bison` and `flex`.

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
* Create the folder `/tmp/Rockmyy-Build` and install the cross-compiled kernel in that folder.

