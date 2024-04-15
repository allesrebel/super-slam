#!/bin/bash

# installs JTOP
sudo pip3 install -U -r requirements.txt

# installs / builds PERF
apt update

apt install -y qt5* 

apt install -y build-essential systemtap-sdt-dev libunwind-dev libslang2-dev libperl-dev libzstd-dev libbabeltrace-ctf-dev flex bison make gcc flex bison pkg-config libzstd1 libdwarf-dev libdw-dev binutils-dev libcap-dev libelf-dev libnuma-dev python3 python3-dev python2-dev python-setuptools python-dev-is-python3 libssl-dev libdwarf-dev zlib1g-dev liblzma-dev libaio-dev libpfm4-dev libslang2-dev systemtap-sdt-dev libperl-dev binutils-dev libbabeltrace-dev libiberty-dev libzstd-dev perl libperl-dev libbpf-dev

wget https://developer.nvidia.com/downloads/embedded/l4t/r36_release_v2.0/sources/public_sources.tbz2 
echo 'untaring public sources'
tar -xjf public_sources.tbz2
echo 'untaring the kernel source'
tar -xjf Linux_for_Tegra/source/kernel_src.tbz2
echo 'building perf!'
make -C kernel/kernel-jammy-src/tools/perf

# clean up
rm public_sources.tbz2
