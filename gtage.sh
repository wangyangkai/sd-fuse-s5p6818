#!/bin/sh

find out/kernel-s5p6818  -name "*.h" -or -name "*.c" -or -name "*.s" -or -name "*.S" > gtags.files

gtags -f gtags.files
