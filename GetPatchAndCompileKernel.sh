export ARCH=arm
export CROSS_COMPILE=arm-linux-gnueabihf-

export KERNEL_GIT_URL='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'

if [ -z ${MAKEOPTS+x} ]; then
	export MAKEOPTS=-j16
fi

export KERNEL_SERIES=v5.0
export KERNEL_BRANCH=v5.0-rc7
export LOCALVERSION=-RockMyy-HighFive-VPU-Beta
export MALI_VERSION=r19p0-01rel0
export MALI_BASE_URL=https://developer.arm.com/-/media/Files/downloads/mali-drivers/kernel/mali-midgard-gpu

export GITHUB_REPO=Miouyouyou/RockMyy
export GIT_BRANCH=RandyLi-Patches-Test

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
export KERNEL_DOCUMENTATION_PATCHES_DIR=$KERNEL_PATCHES_DIR/Documentation
export CONFIG_FILE_PATH=config/$KERNEL_SERIES/config-latest

export BASE_FILES_URL=https://raw.githubusercontent.com/$GITHUB_REPO/$GIT_BRANCH
export KERNEL_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DIR
export KERNEL_DTS_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_PATCHES_DTS_DIR
export KERNEL_DOCUMENTATION_PATCHES_DIR_URL=$BASE_FILES_URL/$KERNEL_DOCUMENTATION_PATCHES_DIR
export MALI_PATCHES_DIR_URL=$BASE_FILES_URL/$MALI_PATCHES_DIR
export CONFIG_FILE_URL=$BASE_FILES_URL/config/$KERNEL_SERIES/config-latest

export KERNEL_PATCHES="
0001-drivers-Integrating-Mali-Midgard-video-and-gpu-drive.patch
0002-clk-rockchip-add-all-known-operating-points-to-the-a.patch
0003-clk-rockchip-rk3288-prefer-vdpu-for-vcodec-clock-sou.patch
0004-Remove-the-dependency-to-the-clk_mali-symbol.patch
0005-drivers-mmc-dw-mci-rockchip-Handle-ASUS-Tinkerboard.patch
0006-soc-rockchip-power-domain-export-idle-request.patch
0007-drivers-wifi-ath9k-reverse-do-not-use-bulk-on-EP3-and-EP4.patch
0008-clk-rockchip-rk3288-Support-for-dedicating-NPLL-to-a.patch
0010-block-partitions-efi-Ignore-GPT-flags-on-Veyron-Chro.patch
0011-block-partitions-efi-Ignore-bizarre-Chromebook-GPT-p.patch
0012-mmc-Added-a-flag-to-disable-cache-flush-during-reset.patch
0013-spi-Added-support-for-Tinkerboard-s-SPI-interface.patch
0100-ARM-dts-rockchip-move-rk3036-i2s-sound-dail-cells-in.patch
0101-ARM-dts-rockchip-add-HCLK_HDMI-to-rk3066-vio-power-d.patch
0102-ARM-dts-rockchip-fix-cif1_pdn-pin-on-rk3188-bqedison.patch
0103-ARM-dts-rockchip-add-focaltech-touchscreen-to-rk3188.patch
0104-arm64-dts-rockchip-add-rk3328-ACODEC-node.patch
0105-arm64-dts-rockchip-move-rk3328-sound-dai-cells-to-th.patch
0106-arm64-dts-rockchip-enable-analog-audio-node-for-rock.patch
0107-clk-rockchip-fix-frac-settings-of-GPLL-clock-for-rk3.patch
0108-clk-rockchip-add-CLK_SET_RATE_PARENT-for-rk3066-lcdc.patch
0109-arm64-dts-rockchip-Add-devicetree-for-NanoPC-T4.patch
0110-ARM-dts-rockchip-add-rk3066-vop-display-nodes.patch
0111-ARM-dts-rockchip-Add-missing-dma-names-SPI-support-f.patch
0112-ARM-dts-rockchip-rv1108-Add-spim0-and-spim1-pinctrl-.patch
0113-dt-bindings-Add-vendor-prefix-for-elgin.patch
0114-ARM-dts-rv1108-Add-support-for-rv1108-elgin-r1-board.patch
0115-arm64-dts-rockchip-add-ROCK-Pi-4-DTS-support.patch
0116-arm64-dts-rockchip-Add-DT-for-NanoPi-M4.patch
0117-arm64-dts-rockchip-Refine-nanopi4-differences.patch
0118-arm64-dts-rockchip-Add-NanoPC-T4-IR-receiver.patch
0119-arm64-dts-rockchip-Fix-nanopi4-uSD-card-detect.patch
0120-ARM-dts-rockchip-clean-up-the-abuse-of-disable-wp.patch
0121-arm64-dts-rockchip-clean-up-the-abuse-of-disable-wp.patch
0122-media-v4l2-mem2mem-add-v4l2_m2m_buf_copy_data-helper.patch
0123-media-vim2m-use-v4l2_m2m_buf_copy_data.patch
0124-media-vicodec-use-v4l2_m2m_buf_copy_data.patch
0125-media-buffer.rst-clean-up-timecode-documentation.patch
0126-media-videodev2.h-add-v4l2_timeval_to_ns-inline-func.patch
0127-media-vb2-add-vb2_find_timestamp.patch
0128-media-cedrus-identify-buffers-by-timestamp.patch
0129-media-extended-controls.rst-update-the-mpeg2-compoun.patch
0130-media-vim2m-the-v4l2_m2m_buf_copy_data-args-were-swa.patch
0131-media-vb2-vb2_find_timestamp-drop-restriction-on-buf.patch
0132-media-vb2-Keep-dma-buf-buffers-mapped-until-they-are.patch
0133-media-cedrus-Remove-completed-item-from-TODO-list-dm.patch
0134-media-vb2-add-buf_out_validate-callback.patch
0135-media-vim2m-add-buf_out_validate-callback.patch
0136-media-vivid-add-buf_out_validate-callback.patch
0137-media-cedrus-add-buf_out_validate-callback.patch
0138-media-vb2-check-that-buf_out_validate-is-present.patch
0139-media-videobuf2-remove-unused-variable.patch
0140-media-vb2-Fix-buf_out_validate-documentation.patch
0141-media-Introduce-helpers-to-fill-pixel-format-structs.patch
0142-rockchip-vpu-Use-pixel-format-helpers.patch
0143-rockchip-vpu-Use-v4l2_m2m_buf_copy_data.patch
0144-rockchip-vpu-Cleanup-macroblock-alignment.patch
0145-rockchip-vpu-Cleanup-JPEG-bounce-buffer-management.patch
0146-rockchip-vpu-Open-code-media-controller-register.patch
0147-rockchip-vpu-Support-the-Request-API.patch
0148-rockchip-vpu-Add-decoder-boilerplate.patch
0149-rockchip-vpu-Add-support-for-non-standard-controls.patch
0150-rockchip-vpu-Add-support-for-MPEG-2-decoding.patch
0151-rockchip-vpu-Add-support-for-RK3328.patch
0152-rockchip-vpu-Add-support-for-MPEG-2-decoding-on-RK32.patch
0153-clk-rockchip-rk3288-fix-vcodec-parent.patch
0154-HACK-rockchip-vpu-register-decoder-as-first-video-de.patch
0155-Revert-media-mpeg2-ctrls.h-move-MPEG2-state-controls.patch
0156-arm64-dts-rockchip-add-rk3328-VPU-nodes.patch
0157-clk-rockchip-fix-bad-clocks-on-rk3328.patch
0158-drm-rockchip-vop-reset-scale-mode-when-win-is-disabl.patch
0159-rockchip-vpu-add-runtime-pm-callbacks.patch
"

export KERNEL_DTS_PATCHES="
0001-dts-rk3288-miqi-Enabling-the-Mali-GPU-node.patch
0002-ARM-dts-rockchip-fix-the-regulator-s-voltage-range-o.patch
0003-ARM-dts-rockchip-add-the-MiQi-board-s-fan-definition.patch
0004-ARM-dts-rockchip-add-support-for-1800-MHz-operation-.patch
0005-Readapt-ARM-dts-rockchip-miqi-add-turbo-mode-operati.patch
0006-ARM-DTSI-rk3288-Missing-GRF-handles.patch
0007-RK3288-DTSI-rk3288-Add-missing-SPI2-pinctrl.patch
0009-ARM-DTSI-rk3288-Adding-cells-addresses-and-size.patch
0010-ARM-DTSI-rk3288-Adding-missing-EDP-power-domain.patch
0011-ARM-DTSI-rk3288-Adding-missing-VOPB-registers.patch
0012-ARM-DTSI-rk3288-Fixed-the-SPDIF-node-address.patch
0013-ARM-DTS-rk3288-tinker-Enabling-SDIO-and-Wifi.patch
0014-ARM-DTS-rk3288-tinker-Setup-the-Bluetooth-UART-pins.patch
0015-ARM-DTSI-rk3288-tinker-Improving-the-CPU-max-voltage.patch
0016-ARM-DTSI-rk3288-tinker-Setting-up-the-SD-regulators.patch
0017-ARM-DTS-rk3288-tinker-Defined-the-I2C-interfaces.patch
0018-ARM-DTS-rk3288-tinker-Defining-the-SPI-interface.patch
0019-ARM-DTSI-rk3288-tinker-Defining-SDMMC-properties.patch
0022-dts-rk3288-veyron-chromebook-dedicate-npll-to-VOP0-H.patch
0023-dts-rk3288-support-for-dedicating-npll-to-a-vop.patch
0024-arm-dts-veyron-Added-a-flag-to-disable-cache-flush-d.patch
0025-ARM-DTSI-Setup-the-VEPU-and-VDPU-nodes-for-the-MPP-S.patch
0026-ARM-DTS-Enable-the-VEPU-VDPU-and-VPU-MMU-on-the-Tink.patch
"

export KERNEL_DOCUMENTATION_PATCHES="
"

export MALI_PATCHES="
0001-Mali-midgard-r19p0-fixes-for-4.13-kernels.patch
0004-Don-t-be-TOO-severe-when-looking-for-the-IRQ-names.patch
0005-Added-the-new-compatible-list-mainly-used-by-Rockchi.patch
0006-gpu-arm-Midgard-setup_timer-timer_setup.patch
0007-drivers-gpu-Arm-Midgard-Replace-ACCESS_ONCE-by-READ_.patch
0008-gpu-arm-midgard-Remove-sys_close-references.patch
0009-GPU-ARM-Midgard-Adapt-to-the-new-mmap-call-checks.patch
0010-GPU-Mali-Midgard-remove-rcu_read_lock-references.patch
0011-mali-kbase-v4.20-to-v5.0-rc2-changes.patch
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
		#download_and_apply_patches $KERNEL_DOCUMENTATION_PATCHES_DIR_URL $KERNEL_DOCUMENTATION_PATCHES
		download_and_apply_patches $MALI_PATCHES_DIR_URL $MALI_PATCHES
	else
		copy_and_apply_patches ../$KERNEL_PATCHES_DIR $KERNEL_PATCHES
		copy_and_apply_patches ../$KERNEL_PATCHES_DTS_DIR $KERNEL_DTS_PATCHES
		#copy_and_apply_patches ../$KERNEL_DOCUMENTATION_PATCHES_DIR $KERNEL_DOCUMENTATION_PATCHES
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


