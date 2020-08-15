export ARCH=arm

if [ -z ${CROSS_COMPILE+x} ]; then
	export CROSS_COMPILE=arm-linux-gnueabihf-
fi

export KERNEL_GIT_URL='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'

if [ -z ${MAKEOPTS+x} ]; then
	export MAKEOPTS=-j16
fi

export KERNEL_SERIES=v5.8
export KERNEL_BRANCH=v5.8
export LOCALVERSION=-RockMyy32-Frosty
export MALI_VERSION=r19p0-01rel0
export MALI_BASE_URL=https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu

export GITHUB_REPO=Miouyouyou/RockMyy
export GIT_BRANCH=master

export DTB_FILES="
rk3288-evb-act8846.dtb
rk3288-evb-rk808.dtb
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
export CONFIG_FILE_PATH=config/$KERNEL_SERIES/config-latest

export BASE_FILES_URL=https://raw.githubusercontent.com/$GITHUB_REPO/$GIT_BRANCH
export KERNEL_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DIR
export KERNEL_DTS_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DTS_DIR
export CONFIG_FILE_URL=$BASE_FILES_URL/config/$KERNEL_SERIES/config-latest

export KERNEL_PATCHES="
0001-drivers-mmc-dw-mci-rockchip-Handle-ASUS-Tinkerboard-.patch
0002-block-partitions-efi-Ignore-GPT-flags-on-Veyron-Chro.patch
0003-block-partitions-efi-Ignore-bizarre-Chromebook-GPT-p.patch
0004-mimick-phy-rockchip-inno-hdmi-Support-more-pre-pll-c.patch
0006-drm-rockchip-vop-filter-modes-outside-0.5-pixel-cloc.patch
0007-drm-rockchip-dw_hdmi-Set-cur_ctr-to-0-always.patch
0008-drm-rockchip-dw_hdmi-adjust-cklvl-txlvl-for-RF-EMI.patch
0009-drm-rockchip-dw_hdmi-Use-auto-generated-tables.patch
0010-drm-rockchip-dw_hdmi-add-default-594Mhz-clk-for-4K-6.patch
0011-drm-rockchip-dw-hdmi-limit-tmds-to-340mhz.patch
0012-HACK-drm-rockchip-vop-limit-resolution-to-3840x2160.patch
0013-MINIARM-set-npll-be-used-for-hdmi-only.patch
0014-clk-rockchip-rk3288-use-npll-table-to-to-improve-HDM.patch
0015-clk-rockchip-rk3288-add-more-npll-clocks.patch
0016-Use-340000-as-fallback-max_tmds_clock.patch
0017-FIXME-Don-t-use-vop_crtc_mode_valid.patch
0018-dma-fence-Reducing-DMA_FENCE_TRACE-to-debug.patch
"

export KERNEL_DTS_PATCHES="
0001-dts-rk3288-miqi-Enabling-the-Mali-GPU-node.patch
0002-arm-dtsi-rk3288-tinker-Added-flags-for-reboot-suppor.patch
0003-arm-dtsi-rk3288-add-GPU-500-Mhz-OPP-again.patch
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

	# Download and apply the various kernel and Mali kernel-space driver patches
	if [ ! -d "../patches" ]; then
		download_and_apply_patches $KERNEL_PATCHES_DIR_URL $KERNEL_PATCHES
		download_and_apply_patches $KERNEL_DTS_PATCHES_DIR_URL $KERNEL_DTS_PATCHES
	else
		copy_and_apply_patches ../$KERNEL_PATCHES_DIR $KERNEL_PATCHES
		copy_and_apply_patches ../$KERNEL_PATCHES_DTS_DIR $KERNEL_DTS_PATCHES
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

if [ ! -z ${APPLYONLY+x} ]; then
  exit
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


