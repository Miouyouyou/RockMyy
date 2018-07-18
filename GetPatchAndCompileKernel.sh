export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

export KERNEL_GIT_URL='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'

if [ -z ${MAKEOPTS+x} ]; then
	export MAKEOPTS=-j16
fi

export KERNEL_SERIES=v4.18
export KERNEL_BRANCH=v4.18-rc5
export LOCALVERSION=-RockMyy-181818
export MALI_VERSION=r19p0-01rel0
export MALI_BASE_URL=https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu

export GITHUB_REPO=Miouyouyou/RockMyy
export GIT_BRANCH=master

export DTB_FILES="
rk3288-evb-act8846.dtb
rk3288-evb-rk808.dtb
rk3288-fennec.dtb
rk3288-firefly-beta.dtb
rk3288-firefly-reload.dtb
rk3288-firefly.dtb
rk3288-tinker.dtb
rk3288-miqi.dtb
rk3288-popmetal.dtb
rk3288-r89.dtb
rk3288-rock2-square.dtb
rk3288-veyron-brain.dtb
rk3288-veyron-jaq.dtb
rk3288-veyron-jerry.dtb
rk3288-veyron-mickey.dtb
rk3288-veyron-minnie.dtb
rk3288-veyron-pinky.dtb
rk3288-veyron-speedy.dtb
"

export PATCHES_DIR=patches
export KERNEL_PATCHES_DIR=$PATCHES_DIR/kernel/$KERNEL_SERIES
export KERNEL_PATCHES_DTS_DIR=$KERNEL_PATCHES_DIR/DTS
export MALI_PATCHES_DIR=$PATCHES_DIR/Midgard/$MALI_VERSION
export CONFIG_FILE_PATH=config/$KERNEL_SERIES/config-latest

export BASE_FILES_URL=https://raw.githubusercontent.com/$GITHUB_REPO/$GIT_BRANCH
export KERNEL_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DIR
export KERNEL_DTS_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DTS_DIR
export MALI_PATCHES_DIR_URL=$BASE_FILES_URL/$MALI_PATCHES_DIR
export CONFIG_FILE_URL=$BASE_FILES_URL/config/$KERNEL_SERIES/config-latest

export KERNEL_PATCHES="
0001-drivers-Integrating-Mali-Midgard-video-and-gpu-drive.patch
0002-clk-rockchip-add-all-known-operating-points-to-the-a.patch
0003-clk-rockchip-rk3288-prefer-vdpu-for-vcodec-clock-sou.patch
0004-Remove-the-dependency-to-the-clk_mali-symbol.patch
0005-drivers-mmc-dw-mci-rockchip-Handle-ASUS-Tinkerboard.patch
0006-soc-rockchip-power-domain-export-idle-request.patch
0007-drivers-drm-rockchip-Enable-IRQ-on-unbind.patch
"

export KERNEL_DTS_PATCHES="
0001-dts-rk3288-miqi-Enabling-the-Mali-GPU-node.patch
0002-ARM-dts-rockchip-fix-the-regulator-s-voltage-range-o.patch
0003-ARM-dts-rockchip-add-the-MiQi-board-s-fan-definition.patch
0004-ARM-dts-rockchip-add-support-for-1800-MHz-operation-.patch
0005-Readapt-ARM-dts-rockchip-miqi-add-turbo-mode-operati.patch
0006-ARM-DTSI-rk3288-Missing-GRF-handles.patch
0007-RK3288-DTSI-rk3288-Add-missing-SPI2-pinctrl.patch
0008-Added-support-for-Tinkerboard-s-SPI-interface.patch
0009-ARM-DTSI-rk3288-Adding-cells-addresses-and-size.patch
0010-ARM-DTSI-rk3288-Adding-missing-EDP-power-domain.patch
0011-ARM-DTSI-rk3288-Adding-missing-VOPB-registers.patch
0012-ARM-DTSI-rk3288-Fixed-the-SPDIF-node-address.patch
0013-ARM-DTS-rk3288-tinker-Enabling-SDIO-and-Wifi.patch
0014-ARM-DTS-rk3288-tinker-Setup-the-Bluetooth-UART-pins.patch
0015-ARM-DTS-rk3288-tinker-Improving-the-CPU-max-volt.patch
0016-ARM-DTS-rk3288-tinker-Setting-up-the-SD-regulato.patch
0017-ARM-DTS-rk3288-tinker-Defined-the-I2C-interfaces.patch
0018-ARM-DTS-rk3288-tinker-Defining-the-SPI-interface.patch
0019-ARM-DTS-rk3288-tinker-Defining-SDMMC-properties.patch
0020-ARM-DTSI-rk3288-Define-the-VPU-services.patch
0021-ARM-DTS-rk3288-miqi-Enable-the-Video-encoding-MM.patch
0022-ARM-DTS-rk3288-tinker-Enable-the-Video-encoding-MMU-.patch
0023-ARM-DTSI-rk3288-firefly-Enable-the-Video-encoding-MM.patch
0024-ARM-DTSI-rk3288-veyron-Enable-the-Video-encoding-MMU.patch
0025-ARM-DTSI-rk3288-Renamed-the-VPU-services-clocks.patch
0026-ARM-DTSI-rk3288-Set-the-VPU-MMU-power-domains.patch
0027-ARM-DTSI-rk3288-veyron-chromebook-Fix-the-EDP-output.patch
0028-ARM-DTSI-rk3288-evb-Fix-the-EDP-output-nodes.patch
"


export MALI_PATCHES="
0001-Mali-midgard-r19p0-fixes-for-4.13-kernels.patch
0004-Don-t-be-TOO-severe-when-looking-for-the-IRQ-names.patch
0005-Added-the-new-compatible-list-mainly-used-by-Rockchi.patch
0006-gpu-arm-Midgard-setup_timer-timer_setup.patch
0007-drivers-gpu-Arm-Midgard-Replace-ACCESS_ONCE-by-READ_.patch
0008-gpu-arm-midgard-Remove-sys_close-references.patch
0009-GPU-ARM-Midgard-Adapt-to-the-new-mmap-call-checks.patch
"

# -- Helper functions

function die_on_error {
	if [ ! $? = 0 ]; then
		echo $1
		exit 1
	fi
}

function download_patches {
	base_url=$1
	patches=${@:2}
	for patch in $patches; do
		wget $base_url/$patch ||
		{ echo "Could not download $patch"; exit 1; }
	done
}

function download_and_apply_patches {
	base_url=$1
	patches=${@:2}
	download_patches $base_url $patches
	git apply $patches
	die_on_error "Could not apply the downloaded patches"
	rm $patches
}

function copy_and_apply_patches {
	patch_base_dir=$1
	patches=${@:2}

	apply_dir=$PWD
	cd $patch_base_dir
	cp $patches $apply_dir ||
	{ echo "Could not copy $patch"; exit 1; }
	cd $apply_dir
	git apply $patches
	die_on_error "Could not apply the copied patches"
	rm $patches
}

# Get the kernel

# If we haven't already clone the Linux Kernel tree, clone it and move
# into the linux folder created during the cloning.
if [ ! -d "linux" ]; then
  git clone --depth 1 --branch $KERNEL_BRANCH $KERNEL_GIT_URL linux
  die_on_error "Could not git the kernel"
fi
cd linux
export SRC_DIR=$PWD

# Check if the tree is patched
if [ ! -e "PATCHED" ]; then
	# If not, cleanup, apply the patches, commit and mark the tree as
	# patched

	# Remove all untracked files. These are residues from failed runs
	git clean -fdx &&
	# Rewind modified files to their initial state.
	git checkout -- .

	# Download, prepare and copy the Mali Kernel-Space drivers.
	# Some TGZ are AWFULLY packaged with everything having 0777 rights.

	wget "$MALI_BASE_URL/TX011-SW-99002-$MALI_VERSION.tgz" &&
	tar zxvf TX011-SW-99002-$MALI_VERSION.tgz &&
	cd TX011-SW-99002-$MALI_VERSION &&
	find . -type 'f' -exec chmod 0644 {} ';' && # Every file   should have -rw-r--r-- rights
	find . -type 'd' -exec chmod 0755 {} ';' && # Every folder should have drwxr-xr-x rights
	find . -name 'sconscript' -exec rm {} ';' && # Remove sconscript files. Useless.
	cd driver/product/kernel &&
	cp -r drivers/gpu/arm  $SRC_DIR/drivers/gpu/ && # Copy the Midgard code
	cd $SRC_DIR &&
	rm -r TX011-SW-99002-$MALI_VERSION TX011-SW-99002-$MALI_VERSION.tgz

	# Download and apply the various kernel and Mali kernel-space driver patches
	if [ ! -d "../patches" ]; then
		download_and_apply_patches $KERNEL_PATCHES_DIR_URL $KERNEL_PATCHES
		download_and_apply_patches $KERNEL_DTS_PATCHES_DIR_URL $KERNEL_DTS_PATCHES
		download_and_apply_patches $MALI_PATCHES_DIR_URL $MALI_PATCHES
	else
		copy_and_apply_patches ../$KERNEL_PATCHES_DIR $KERNEL_PATCHES
		copy_and_apply_patches ../$KERNEL_PATCHES_DTS_DIR $KERNEL_DTS_PATCHES
		copy_and_apply_patches ../$MALI_PATCHES_DIR $MALI_PATCHES
	fi


	# Cleanup, get the configuration file and mark the tree as patched
	echo "RockMyy" > PATCHED &&
	git add . &&
	git commit -m "Apply ALL THE PATCHES !"
fi

# Download a .config file if none present
if [ ! -e ".config" ]; then
	make mrproper
	if [ ! -f "../$CONFIG_FILE_PATH" ]; then
		wget -O .config $CONFIG_FILE_URL
	else
		cp "../$CONFIG_FILE_PATH" .config
	fi
	die_on_error "Could not get the configuration file..."
fi

if [ -z ${MAKE_CONFIG+x} ]; then
  export MAKE_CONFIG=oldconfig
fi

make $MAKE_CONFIG
make $DTB_FILES zImage modules $MAKEOPTS
die_on_error "Compilation failed"

if [ -z ${DONT_INSTALL_IN_TMP+x} ]; then
	# Kernel compiled
	# This will just copy the kernel files and libraries in /tmp
	# This part is only useful if you're cross-compiling the kernel, of course
	export INSTALL_MOD_PATH=/tmp/RockMyy-Build
	export INSTALL_PATH=$INSTALL_MOD_PATH/boot
	export INSTALL_HDR_PATH=$INSTALL_MOD_PATH/usr
	mkdir -p $INSTALL_MOD_PATH $INSTALL_PATH $INSTALL_HDR_PATH
	make modules_install &&
	make install &&
	make INSTALL_HDR_PATH=$INSTALL_HDR_PATH headers_install && # This command IGNORES predefined variables
	cp arch/arm/boot/zImage $INSTALL_PATH &&
	cp arch/arm/boot/dts/*.dtb $INSTALL_PATH
fi


