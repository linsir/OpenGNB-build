#!/bin/bash

log_info() {
    # Usage: log_info "this is the info log message"
    NOW=$(date +"%Y-%m-%d %H:%M:%S")
    echo -e "${NOW} [INFO] $1"
}
echo_separator() {
    # Usage: echo_separator
    echo "===================================================="
}


GNB_VERSION=$(cat opengnb/version)

log_info "GNB_VERSION: ${GNB_VERSION}"
log_info "GITHUB_WORKSPACE: ${GITHUB_WORKSPACE}"



# build 19.07.2-ar71xx
echo_separator
log_info "build 19.07.2-ar71xx"
cd $GITHUB_WORKSPACE
log_info "download http://oss.apichop.com/gnb/build/openwrt-sdk-19.07.2-ar71xx-simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/19.07.2-ar71xx
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-19.07.2-ar71xx-simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/19.07.2-ar71xx

export PATH=$PATH:$GITHUB_WORKSPACE/19.07.2-ar71xx/staging_dir/toolchain-mips_24kc_gcc-7.5.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/19.07.2-ar71xx/staging_dir/
export CC=mips-openwrt-linux-gcc
export CXX=mips-openwrt-linux-g++

cd opengnb
make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

log_info "build opengnb_${GNB_VERSION}_19.07.2-ar71xx.tar.gz to $GITHUB_WORKSPACE/dist"
tar zcf opengnb_${GNB_VERSION}_19.07.2-ar71xx.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_19.07.2-ar71xx.tar.gz $GITHUB_WORKSPACE/dist

log_info "build 19.07.2-ar71xx done"


# build 21.02.0-mt76x8
echo_separator
log_info "build 21.02.0-mt76x8"
cd $GITHUB_WORKSPACE

log_info "download http://oss.apichop.com/gnb/build/openwrt-sdk-21.02.0-mt76x8_simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/21.02.0-mt76x8
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-21.02.0-mt76x8_simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/21.02.0-mt76x8

export PATH=$PATH:$GITHUB_WORKSPACE/21.02.0-mt76x8/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/21.02.0-mt76x8/staging_dir/
export CC=mipsel-openwrt-linux-gcc
export CXX=mipsel-openwrt-linux-g++

cd opengnb
make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

tar zcf opengnb_${GNB_VERSION}_21.02.0-mt76x8.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_21.02.0-mt76x8.tar.gz $GITHUB_WORKSPACE/dist
log_info "build 21.02.0-mt76x8 done"

# build 22.7.7-mt7621
echo_separator
log_info "build 22.7.7-mt7621"
cd $GITHUB_WORKSPACE
log_info "download http://oss.apichop.com/gnb/build/openwrt-sdk-22.7.7-mt7621_simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/22.7.7-mt7621
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-22.7.7-mt7621_simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/22.7.7-mt7621

export PATH=$PATH:$GITHUB_WORKSPACE/22.7.7-mt7621/staging_dir/toolchain-mipsel_24kc_gcc-8.4.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/22.7.7-mt7621/staging_dir/
export CC=mipsel-openwrt-linux-gcc
export CXX=mipsel-openwrt-linux-g++

cd opengnb
make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

tar zcf opengnb_${GNB_VERSION}_22.7.7-mt7621.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_22.7.7-mt7621.tar.gz $GITHUB_WORKSPACE/dist
log_info "build 22.7.7-mt7621 done"

# build 23.11.20-ipq6000
echo_separator
log_info "build 23.11.20-ipq6000"
cd $GITHUB_WORKSPACE
log_info "download http://oss.apichop.com/gnb/build/openwrt-sdk-23.11.20-ipq6000_simple.tar.gz"
mkdir -p $GITHUB_WORKSPACE/23.11.20-ipq6000
curl -s http://oss.apichop.com/gnb/build/openwrt-sdk-23.11.20-ipq6000_simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/23.11.20-ipq6000

export PATH=$PATH:$GITHUB_WORKSPACE/23.11.20-ipq6000/staging_dir/toolchain-aarch64_cortex-a53_gcc-7.5.0_musl/bin/
export STAGING_DIR=$GITHUB_WORKSPACE/23.11.20-ipq6000/staging_dir/
export CC=mipsel-openwrt-linux-gcc
export CXX=mipsel-openwrt-linux-g++

cd opengnb
make -f Makefile.openwrt clean &&make -f Makefile.openwrt install

tar zcf opengnb_${GNB_VERSION}_23.11.20-ipq6000.tar.gz -C bin .
mkdir -p $GITHUB_WORKSPACE/dist
cp -af opengnb_${GNB_VERSION}_23.11.20-ipq6000.tar.gz $GITHUB_WORKSPACE/dist
log_info "build 23.11.20-ipq6000 done"