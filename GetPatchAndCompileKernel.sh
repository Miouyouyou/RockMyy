export ARCH=arm
export CROSS_COMPILE=armv7a-hardfloat-linux-gnueabi-

export KERNEL_GIT_URL='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'

export KERNEL_SERIES=v4.13
export KERNEL_BRANCH=v4.13-rc3
export LOCALVERSION=-RockMyy-XIII-VPU-Test
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
0001-Integrating-the-Mali-drivers.patch
0002-fbdev-Mali-Add-the-FBIOGET_DMABUF-interface.patch
0003-clk-rockchip-add-all-known-operating-points-to-the-a.patch
0004-clk-rockchip-rk3288-prefer-vdpu-for-vcodec-clock-sou.patch
0005-Remove-the-dependency-to-the-clk_mali-symbol.patch
0006-soc-rockchip-power-domain-export-idle-request.patch
0007-Reboot-patch-2-The-Return.patch
0008-rockchip-rga-v4l2-m2m-support.patch
0009-dt-bindings-Document-the-Rockchip-RGA-bindings.patch
0010-Rockchip-DRM-GEM-Prime-import-SG-Table-Support.patch
0011-drm_fourcc-Add-new-P010-P016-video-format.patch
0012-Rockchip-10-bits-video-support-adapted-from-ayaka-pa.patch
0013-FIXME-Remove-DRM-security-for-testing-purposes.patch
"

export KERNEL_DTS_PATCHES="
0001-Enabling-the-Mali-GPU-nodes-in-the-MiQi-and-Tinkerbo.patch
0002-ARM-dts-rockchip-fix-the-regulator-s-voltage-range-o.patch
0003-Adaptation-ARM-dts-rockchip-add-the-MiQi-board-s-fan.patch
0004-ARM-dts-rockchip-add-support-for-1800-MHz-operation-.patch
0005-Readapt-ARM-dts-rockchip-miqi-add-turbo-mode-operati.patch
0006-ARMbian-RK3288-DTSI-changes.patch
0007-Enabling-Tinkerboard-s-Wifi-Third-tentative.patch
0008-Added-support-for-Tinkerboard-s-SPI-interface.patch
0009-Define-VPU-services-in-the-Rockchip-3288-DTS-files.patch
0010-Common-RK3288-DTSI-additions-by-ARMbian.patch
0011-Fixes-imported-from-and-tested-by-the-ARMbian-team.patch
0012-Tinkerboard-DTS-Define-the-Bluetooth-node.patch
0013-Rockchip-DTSI-Fixed-a-few-typos-in-Rockchip-DTSI-fil.patch
0014-Add-VPU-MMU-clock-names.patch
0015-rk3288-tinker.dts-Few-additions-copied-on-TonyMac32.patch
"

export MALI_PATCHES="
0001-Mali-midgard-r19p0-fixes-for-4.13-kernels.patch
0002-Using-the-new-header-on-4.12-kernels-for-copy_-_user.patch
0003-Adapt-get_user_pages-calls-to-use-the-new-calling-pr.patch
0004-Don-t-be-TOO-severe-when-looking-for-the-IRQ-names.patch
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
  rm -r 'patches' 'license.txt' && # Remove the patches and GPL license file.
  cp -r drivers/gpu/arm  $SRC_DIR/drivers/gpu/ && # Copy the Midgard code
  cp -r drivers/base/ump $SRC_DIR/drivers/base/ && # Copy the Unified Memory Provider code
  cp include/linux/ump*  $SRC_DIR/include/linux/ && # Copy the Unified Memory Provider headers.
  cp include/linux/kds.h $SRC_DIR/include/linux/ && # Copy the Kernel Dependency System header ↑ (dependency)
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
make $DTB_FILES zImage modules -j5
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


