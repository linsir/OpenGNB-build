#!/bin/bash

set -ex -o pipefail

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


build_openwrt_bin(){
    arch_version=$1
    toolchain_version=$2
    cpu_arch=$3
    echo_separator
    log_info "arch_version: ${arch_version}"
    log_info "toolchain_version: ${toolchain_version}"
    log_info "cpu_arch: ${cpu_arch}"
    cd $GITHUB_WORKSPACE
    log_info "download ${OPENWRT_SDK_DOWNLOAD_BASE_URL}/openwrt-sdk-${arch_version}-simple.tar.gz"
    mkdir -p $GITHUB_WORKSPACE/${arch_version}
    curl -s ${OPENWRT_SDK_DOWNLOAD_BASE_URL}/openwrt-sdk-${arch_version}-simple.tar.gz |tar -zx -C $GITHUB_WORKSPACE/${arch_version}

    if [ ! -d $GITHUB_WORKSPACE/${arch_version}/staging_dir/toolchain-${toolchain_version}/bin/ ];
    then
        log_info "toolchain not found"
        exit 1
    fi
    export PATH=$PATH:$GITHUB_WORKSPACE/${arch_version}/staging_dir/toolchain-${toolchain_version}/bin/
    export STAGING_DIR=$GITHUB_WORKSPACE/${arch_version}/staging_dir/
    export CC=${cpu_arch}-openwrt-linux-gcc
    export CXX=${cpu_arch}-openwrt-linux-g++

    cd opengnb

    make -f Makefile.openwrt clean &&make -f Makefile.openwrt install
    log_info "build opengnb_${GNB_VERSION}_${arch_version}.tar.gz to $GITHUB_WORKSPACE/dist"
    tar zcf opengnb_${GNB_VERSION}_${arch_version}.tar.gz -C bin .
    mkdir -p $GITHUB_WORKSPACE/dist
    cp -af opengnb_${GNB_VERSION}_${arch_version}.tar.gz $GITHUB_WORKSPACE/dist
    log_info "build ${arch_version} done"
    }

main(){
    build_openwrt_bin "19.07.2-ar71xx" "mips_24kc_gcc-7.5.0_musl" "mips"
    build_openwrt_bin "21.02.0-mt76x8" "mipsel_24kc_gcc-8.4.0_musl" "mipsel"
    build_openwrt_bin "22.7.7-mt7621" "mipsel_24kc_gcc-8.4.0_musl" "mipsel"
    build_openwrt_bin "23.11.20-ipq6000" "aarch64_cortex-a53_gcc-7.5.0_musl" "aarch64"
}

main;