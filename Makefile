TOP_DIR:= $(shell cd $(PWD)/`dirname $(PARAM_FILE)`; pwd)

.PHONY: usage
usage:
	@echo "build help"
	@echo "make dl_kernel_uboot    -- git clone kernel uboot code"
	@echo "make toolchain          -- unzip the cross compilation tool"
	@echo "make all                -- build all, bootloader kernel rootfs"
	@echo "make uboot              -- build only uboot"
	@echo "make kernel             -- build only kernel"
	@echo 

.PHONY: dl_kernel_uboot toolchain all uboot kernel

all: uboot kernel

dl_kernel_uboot:
	@echo "~~~ git clone kernel uboot code"
	@./dl-kernel-uboot.sh


toolchain:
	@echo "~~~ decompres the cross compilation tool"
#tar -cvjf - 6.4-aarch64 | split -b 20M - 6.4-aarch64.tar.bz2
	@cd $(TOP_DIR)/toolchain; sudo mkdir -p /opt/FriendlyARM/toolchain; cat 6.4-aarch64.tar.bz2* | sudo tar xvj -C /opt/FriendlyARM/toolchain/;

	@echo "\n/opt/FriendlyARM/toolchain/6.4-aarch64/bin/aarch64-linux-gcc -v"
	@/opt/FriendlyARM/toolchain/6.4-aarch64/bin/aarch64-linux-gcc -v


uboot:
	@echo "~~~ make uboot"
	@./build-uboot.sh friendlycore-arm64
	@echo "\nbuild uboot done"

kernel:
	@echo "~~~ make kernel"
	@./build-kernel.sh friendlycore-arm64
	@echo "\nbuild kernel done"
