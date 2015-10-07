#! /usr/bin/env sh

#	Reminder:
# You need to install ROOT
#	go here: https://root.cern.ch/drupal/
#	for further documentation.

export workingDir=`pwd`
mkdir bin
#echo $PIN_ROOT

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
PIN_ROOT=`pwd`/"$PINBASE"
export PIN_ROOT
echo "PIN_ROOT set at: " $PIN_ROOT
echo
echo 0 > proc/sys/kernel/yama/ptrace_scope
echo
# Get CCTLib
echo Getting CCTLib
git init
git clone https://github.com/chabbimilind/cctlib
cd cctlib
autoreconf -ivf # making sure "aclocal-1.14" is present in the system.
sh build.sh
cd src/obj-intel64/
cp libcctlib.a libcctlib_metric.a libcctlib_tree_based.a ../../../src/

cd ../../../src
echo

# Generate the PIN interceptors
echo Generating interceptor functions...
python interceptorGen.py > interceptorGen.h

export BOOST_ROOT=$workingDir/cctlib/boost_1_56_0-install
export LIBELF_ROOT=$workingDir/cctlib/libelf-0.8.9-install

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BOOST_ROOT/lib:$LIBELF_ROOT/lib:$PIN_ROOT/intel64/lib:$PIN_ROOT/intel64/lib-ext

# Compile the PIN tool
echo Compiling cptnHook
PINHOOKNAME="cptnHook"
g++ -DBIGARRAY_MULTIPLIER=1 -Wall -Werror -Wno-unknown-pragmas -fno-stack-protector -Wno-unused-variable -DTARGET_IA32E -DHOST_IA32E -fPIC -DTARGET_LINUX  -I$PIN_ROOT/source/include/pin -I$PIN_ROOT/source/include/pin/gen -I$PIN_ROOT/extras/components/include -I$PIN_ROOT/extras/xed-intel64/include -I$PIN_ROOT/source/tools/InstLib -O3 `root-config --cflags --libs` -fomit-frame-pointer -fno-strict-aliasing -L$ROOTSYS -c -g -o $PINHOOKNAME.o $PINHOOKNAME.cpp -std=c++11

#-L$ROOTSYS
mv "$PINHOOKNAME".o ../bin
cd ../bin

# Make a shared library
#g++ -shared -Wl,--hash-style=sysv -Wl,-Bsymbolic -Wl,--version-script=$PIN_ROOT/source/include/pin/pintool.ver -L$PIN_ROOT/intel64/lib -L$PIN_ROOT/intel64/lib-ext -L$PIN_ROOT/intel64/runtime/glibc -L$PIN_ROOT/extras/xed-intel64/lib -lpin -lxed -lpindwarf -ldl -L$ROOTSYS `root-config --cflags --libs` -L$workingDir/cctlib/src/obj-intel64 -lcctlib -lcctlib_metric -lcctlib_tree_based -L$workingDir/cctlib/boost_1_56_0-install/lib/ -lboost_filesystem -lboost_system-mt -L$workingDir/cctlib/libelf-0.8.9-install/lib -lelf -L$PIN_ROOT/intel64/lib-ext -lpindwarf -L$PIN_ROOT/intel64/lib -lpin -lpinapp -lpinvm -lsapin -o lib$PINHOOKNAME.so $PINHOOKNAME.o
g++ -shared -Wl,--hash-style=sysv -Wl,-Bsymbolic -Wl,--version-script=$PIN_ROOT/source/include/pin/pintool.ver -L$PIN_ROOT/intel64/lib -L$PIN_ROOT/intel64/lib-ext -L$PIN_ROOT/intel64/runtime/glibc -L$PIN_ROOT/extras/xed-intel64/lib -lpin -lxed -lpindwarf -ldl -L$ROOTSYS `root-config --cflags --libs` -L$workingDir/cctlib/src/obj-intel64 -lcctlib -lcctlib_metric -lcctlib_tree_based -L$workingDir/cctlib/boost_1_56_0-install/lib/ -lboost_filesystem -lboost_system -L$workingDir/cctlib/libelf-0.8.9-install/lib -lelf -L$PIN_ROOT/intel64/lib-ext -lpindwarf -L$PIN_ROOT/intel64/lib -lpin -lpinapp -lpinvm -lsapin -o lib$PINHOOKNAME.so $PINHOOKNAME.o

cd ../

echo Compilation ended. 
echo 
echo If no error messages,the libcptnHook library is ready.
echo To run an example run the following: sh Compile_and_Run_Test.sh
echo
echo '!!! BEFORE MOVING ON DO THE FOLLOWING: !!!'
echo
echo '1. set PIN_ROOT, BOOST_ROOT, LIBELF_ROOT and cptnHookLib_Path env variables to the locations of the respectives folders.'
echo '   Preferably export them to bashrc: '
echo '   type: '
echo '      nano ~/.bashrc'
echo '   and add at the end:'
echo '      export PIN_ROOT=[path to PIN folder]'
echo '      export BOOST_ROOT=[path to BOOST folder (inside the CCTLib folder)]'
echo '      export LIBELF_ROOT=[path to LIBELF folder (inside the CCTLib folder)]'
echo '      export cptnHookLib_Path=[path to the bin folder that contains libcptnHook.so]'
echo
echo '2. export to the LD_LIBRARY_PATH the following:'
echo '   Preferably export it to bashrc- '
echo '   type: '
echo '      nano ~/.bashrc'
echo '   and add at the end:'
echo '      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$BOOST_ROOT/lib:$LIBELF_ROOT/lib:$PIN_ROOT/intel64/lib:$PIN_ROOT/intel64/lib-ext'
echo
