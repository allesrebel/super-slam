#!/bin/bash

pip install jetson-stats

apt update

apt install -y qt5* 

apt install -y build-essential systemtap-sdt-dev libunwind-dev libslang2-dev libperl-dev libzstd-dev libbabeltrace-ctf-dev flex bison make gcc flex bison pkg-config libzstd1 libdwarf-dev libdw-dev binutils-dev libcap-dev libelf-dev libnuma-dev python3 python3-dev python-setuptools python-dev-is-python2 libssl-dev libdwarf-dev zlib1g-dev liblzma-dev libaio-dev libpfm4-dev libslang2-dev systemtap-sdt-dev libperl-dev binutils-dev libbabeltrace-dev libiberty-dev libzstd-dev perl libperl-dev

make -C linux-tegra-5.10/tools/perf
