#! /usr/bin/env sh

#
# DO NOT FORGET TO:
# 1. set PIN_ROOT, BOOST_ROOT, LIBELF_ROOT and cptnHookLib_Path env variables to the locations of the respectives folders.'
#    Preferably export them to bashrc: '
#    type: '
#    	nano ~/.bashrc'
#    and add at the end:'
#    	export PIN_ROOT=[path to PIN folder]'
#       export BOOST_ROOT=[path to BOOST folder (inside the CCTLib folder)]'
#       export LIBELF_ROOT=[path to LIBELF folder (inside the CCTLib folder)]'
#       export cptnHookLib_Path=[path to the bin folder that contains libcptnHook.so]'
#
# 2. export to the LD_LIBRARY_PATH the following:'
#    Preferably export it to bashrc- '
#    type: '
#    	nano ~/.bashrc'
#    and add at the end:'
#       export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BOOST_ROOT/lib:$LIBELF_ROOT/lib:$PIN_ROOT/intel64/lib:$PIN_ROOT/intel64/lib-ext'

# LOCAL assignment for PIN_ROOT, BOOST_ROOT and LIBELF_ROOT and addition to LD_LIBRARY_PATH.
workingDir=`pwd`
PIN_ROOT=$workingDir/pin-2.14-71313-gcc.4.4.7-linux
BOOST_ROOT=$workingDir/cctlib/boost_1_56_0-install
LIBELF_ROOT=$workingDir/cctlib/libelf-0.8.9-install

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BOOST_ROOT/lib:$LIBELF_ROOT/lib:$PIN_ROOT/intel64/lib:$PIN_ROOT/intel64/lib-ext

# Compile and Run a Test 
cd Tests
g++ -std=c++11 -o simpleFunc simpleFunc.cpp
cd ../bin
$PIN_ROOT/pin -t libcptnHook.so -- ../Tests/simpleFunc
