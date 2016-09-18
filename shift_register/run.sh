#!/bin/bash

set -e

function clean {
    mkdir -p work osvvm
    ghdl --clean --workdir=work
    ghdl --clean --workdir=osvvm
    ghdl --remove --workdir=work
    rm -rf work
}

function build_OSVVM {
    mkdir -p osvvm
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/NamePkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/OsvvmGlobalPkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/TranscriptPkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/TextUtilPkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/AlertLogPkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/SortListPkg_int.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/RandomBasePkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/RandomPkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/MessagePkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/CoveragePkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/MemoryPkg.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/OsvvmContext.vhd
    ghdl -a --std=08 --work=osvvm --workdir=osvvm --ieee=standard OSVVM/TbUtilPkg.vhd
}

function compile {
    mkdir -p work
    ghdl -c --workdir=work --std=08 --ieee=standard -Posvvm *.vhd -e shift_reg_tb
}

function run {
    ghdl -r shift_reg_tb
}

function wave {
    mkdir -p work
    ghdl -r shift_reg_tb --vcd=work/shift_reg.vcd --stop-time=3000ns
    gtkwave work/shift_reg.vcd 2> /dev/null
}

clean
build_OSVVM
compile
#run
wave
