#!/bin/sh

scp out/kernel-s5p6818/arch/arm64/boot/Image pi@192.168.0.11:/home/pi/firmware/
scp out/kernel-s5p6818/arch/arm64/boot/dts/nexell/s5p6818-nanopi3-*.dtb pi@192.168.0.11:/home/pi/firmware/

rm out/output_s5p6818_kmodules/lib/modules/4.4.172-s5p6818/build
rm out/output_s5p6818_kmodules/lib/modules/4.4.172-s5p6818/source
#scp -r out/output_s5p6818_kmodules/lib/modules/4.4.172-s5p6818 pi@192.168.0.11:/home/pi/firmware/
