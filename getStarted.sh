#! /usr/bin/env sh

#	Reminder:
# You need to install ROOT
#	go here: https://root.cern.ch/drupal/
#	for further documentation.

mkdir bin
echo $PINDIR

# Get cptnHook
#git init
#git clone https://github.com/emyrto/cptnHook.git

# Get Pin
PINBASE="pin-2.14-71313-gcc.4.4.7-linux"
PINTARBALL="$PINBASE".tar.gz
echo Getting PIN...
wget http://software.intel.com/sites/landingpage/pintool/downloads/"$PINTARBALL"
echo Unpacking PIN...
tar -zxf $PINTARBALL
PINDIR=`pwd`/"$PINBASE"
export PINDIR
echo "PINDIR set at: " $PINDIR

cd src

# Generate the PIN interceptors
echo Generating interceptor functions...
python interceptorGen.py > interceptorGen.h

# Compile the PIN tool
echo Compiling cptnHook
PINHOOKNAME="cptnHook"
g++ -DBIGARRAY_MULTIPLIER=1 -Wall -Werror -Wno-unknown-pragmas -fno-stack-protector -Wno-unused-variable -DTARGET_IA32E -DHOST_IA32E -fPIC -DTARGET_LINUX  -I$PINDIR/source/include/pin -I$PINDIR/source/include/pin/gen -I$PINDIR/extras/components/include -I$PINDIR/extras/xed-intel64/include -I$PINDIR/source/tools/InstLib -O3 `root-config --cflags --libs` -fomit-frame-pointer -fno-strict-aliasing -L$ROOTSYS -c -o cptnHook.o cptnHook.cpp -std=c++11

#-L$ROOTSYS
mv "$PINHOOKNAME".o ../bin
cd ../bin

# Make a shared library
g++ -shared -Wl,--hash-style=sysv -Wl,-Bsymbolic -Wl,--version-script=$PINDIR/source/include/pin/pintool.ver    -o libcptnHook.so cptnHook.o  -L$PINDIR/intel64/lib -L$PINDIR/intel64/lib-ext -L$PINDIR/intel64/runtime/glibc -L$PINDIR/extras/xed-intel64/lib -lpin -lxed -lpindwarf -ldl -L$ROOTSYS `root-config --cflags --libs`
echo Compilation ended. 
echo 
echo The libcptnHook library is ready.
echo To run an example run the following: sh Compile_and_Run_Test.sh
echo Remember to set the PINDIR env variable to $PINDIR
echo
