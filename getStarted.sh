# Prerequisites:
# 
#1.	You need to download PIN
#	go here: https://software.intel.com/en-us/articles/pin-a-binary-instrumentation-tool-downloads
#	and download the appropriate version for LINUX according to your compiler.
#
#2.	set PINDIR as the path to the place you downloaded PIN
#	PINDIR=[path]
#	export $PINDIR
#
#3	You need to install ROOT
#	go here: https://root.cern.ch/drupal/
#	for further documentation

echo $PINDIR

# Get cptnHook
#git init
#git clone https://github.com/emyrto/cptnHook.git
cd src

# Generate the PIN interceptors
python interceptorGen.py > interceptorGen.h

# Compile the PIN tool
g++ -DBIGARRAY_MULTIPLIER=1 -Wall -Werror -Wno-unknown-pragmas -fno-stack-protector -Wno-unused-variable -DTARGET_IA32E -DHOST_IA32E -fPIC -DTARGET_LINUX  -I$PINDIR/source/include/pin -I$PINDIR/source/include/pin/gen -I$PINDIR/extras/components/include -I$PINDIR/extras/xed-intel64/include -I$PINDIR/source/tools/InstLib -O3 `root-config --cflags --libs` -fomit-frame-pointer -fno-strict-aliasing -L$ROOTSYS -c -o myPinHookRoot.o myPinHookRoot.cpp -std=c++11 -I/home/myrto/cctlib/src

mv myPinHookRoot.so ../bin
cd ../bin

# Make a shared library
g++ -shared -Wl,--hash-style=sysv -Wl,-Bsymbolic -Wl,--version-script=$PINDIR/source/include/pin/pintool.ver -o myPinHookRoot.so myPinHookRoot.o  -L$PINDIR/intel64/lib -L$PINDIR/intel64/lib-ext -L$PINDIR/intel64/runtime/glibc -L$PINDIR/extras/xed-intel64/lib -lpin -lxed -lpindwarf -ldl -L$ROOTSYS `root-config --cflags --libs`
