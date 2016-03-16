#!/bin/sh -e

sh -e modules/Binutils/build-i686-pc-dayos
sh -e scripts/setup-disk.sh

mkdir build
cd build
sh ../run-cmake.sh
