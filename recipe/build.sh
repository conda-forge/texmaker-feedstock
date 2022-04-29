#!/bin/bash

mkdir build
cd build

## because qmake.
ln -sfT ${CXX} ${PREFIX}/bin/g++ || true
ln -sfT ${CXX} ${PREFIX}/bin/gcc || true

qmake \
    PREFIX=$PREFIX \
    QMAKE_CC=${CC} \
    QMAKE_CXX=${CXX} \
    QMAKE_LINK=${CXX} \
    QMAKE_RANLIB=${RANLIB} \
    QMAKE_OBJDUMP=${OBJDUMP} \
    QMAKE_STRIP=${STRIP} \
    QMAKE_AR="${AR} cqs" \
    ../texmaker.pro

make -j$CPU_COUNT
make check
sed -i "s:(INSTALL_ROOT)/usr:(INSTALL_ROOT)$PREFIX:g" Makefile
make install

rm -f ${PREFIX}/bin/gcc
rm -f ${PREFIX}/bin/g++
