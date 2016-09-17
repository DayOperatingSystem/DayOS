#!/bin/sh
export PREFIX=$PWD/rootsys
export PATH=$PWD/rootsys/bin:$PREFIX/usr/bin:$PATH
export TARGET=i686-pc-dayos
export CC=$TARGET-gcc
export CXX=$TARGET-g++

sh
