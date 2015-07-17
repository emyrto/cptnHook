# Compile and Run a Test 
cd ~/cptnHook/Tests
g++ -std=c++11 -o simpleFunc simpleFunc.cpp
cd ../bin
$PINDIR/pin -t libcptnHook.so -- ../Tests/simpleFunc
