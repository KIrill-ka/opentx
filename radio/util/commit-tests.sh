#!/bin/bash

# Stops on first error, echo on
set -e
set -x

mkdir build
cd build 

# OpenTX on Taranis and Companion
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Debug -DPCB=TARANIS .. 
make
make firmware.bin
make gtests
./gtests

# OpenTX on 9X stock
rm -rf *
cmake -DCMAKE_BUILD_TYPE=Debug -DPCB=9X -DEXT=FRSKY -DHELI=YES .. 
make -j2 firmware.bin
make -j2 gtests
./gtests


# OpenTX on 9X stock with MAVLINK
make clean
make PCB=9X EXT=MAVLINK HELI=YES

# OpenTX on Taranis X9E
make clean
make        PCB=TARANIS PCBREV=REV9E HELI=YES GVARS=YES LUA=YES WARNINGS_AS_ERRORS=YES
make simu   PCB=TARANIS PCBREV=REV9E HELI=YES GVARS=YES LUA=YES
make gtests PCB=TARANIS PCBREV=REV9E HELI=YES GVARS=YES LUA=YES
./gtests

# OpenTX on Taranis Plus
make clean
make        PCB=TARANIS PCBREV=REVPLUS HELI=YES LUA=YES WARNINGS_AS_ERRORS=YES
make simu   PCB=TARANIS PCBREV=REVPLUS HELI=YES LUA=YES
make gtests PCB=TARANIS PCBREV=REVPLUS HELI=YES LUA=YES
./gtests

# OpenTX on Taranis
make clean
make        PCB=TARANIS HELI=YES LUA=YES WARNINGS_AS_ERRORS=YES
make simu   PCB=TARANIS HELI=YES LUA=YES
make gtests PCB=TARANIS HELI=YES LUA=YES
./gtests

# OpenTX on Sky9x
make clean
make        PCB=SKY9X HELI=YES WARNINGS_AS_ERRORS=YES
make simu   PCB=SKY9X HELI=YES
make gtests PCB=SKY9X HELI=YES
./gtests

# OpenTX on Gruvin9x
make clean
make      PCB=GRUVIN9X EXT=FRSKY SDCARD=YES
make simu PCB=GRUVIN9X EXT=FRSKY SDCARD=YES

# OpenTX on MEGA2560
make clean
make PCB=MEGA2560

# OpenTX on MEGA2560 with MAVLINK
make clean
make PCB=MEGA2560 EXT=MAVLINK

# OpenTX on Horus
make clean
make        PCB=HORUS HELI=NO USB=SERIAL CLI=YES DEBUG=YES
make simu   PCB=HORUS
