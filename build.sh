#!/bin/bash

GNB_VERSION=$(cat opengnb/version)

# build 19.07.2-ar71xx

echo "download http://oss.apichop.com/gnb/build/openwrt-sdk-19.07.2-ar71xx-simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/19.07.2-ar71xx
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-19.07.2-ar71xx-simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/19.07.2-ar71xx

export PATH=$PATH:$GITHUB_WORKSPACE/19.07.2-ar71xx/staging_dir/toolchain-mips_24kc_gcc-7.5.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/19.07.2-ar71xx/staging_dir/
export CC=mips-openwrt-linux-gcc
export CXX=mips-openwrt-linux-g++

make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

tar zcf opengnb_${GNB_VERSION}_19.07.2-ar71xx.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_19.07.2-ar71xx.tar.gz $GITHUB_WORKSPACE/dist


# build 21.02.0-mt76x8

echo "download http://oss.apichop.com/gnb/build/openwrt-sdk-21.02.0-mt76x8_simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/21.02.0-mt76x8
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-21.02.0-mt76x8_simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/21.02.0-mt76x8

export PATH=$PATH:$GITHUB_WORKSPACE/21.02.0-mt76x8/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/21.02.0-mt76x8/staging_dir/
export CC=mipsel-openwrt-linux-gcc
export CXX=mipsel-openwrt-linux-g++

make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

tar zcf opengnb_${GNB_VERSION}_21.02.0-mt76x8.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_21.02.0-mt76x8.tar.gz $GITHUB_WORKSPACE/dist


# build 22.7.7-mt7621

echo "download http://oss.apichop.com/gnb/build/openwrt-sdk-22.7.7-mt7621_simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/22.7.7-mt7621
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-22.7.7-mt7621_simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/22.7.7-mt7621

export PATH=$PATH:$GITHUB_WORKSPACE/22.7.7-mt7621/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/22.7.7-mt7621/staging_dir/
export CC=mipsel-openwrt-linux-gcc
export CXX=mipsel-openwrt-linux-g++

make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

tar zcf opengnb_${GNB_VERSION}_22.7.7-mt7621.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_22.7.7-mt7621.tar.gz $GITHUB_WORKSPACE/dist