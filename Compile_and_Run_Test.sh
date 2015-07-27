#! /usr/bin/env sh

# Compile and Run a Test 
cd Tests
g++ -std=c++11 -o simpleFunc simpleFunc.cpp
cd ../bin
../pin-2.14-71313-gcc.4.4.7-linux/pin -t libcptnHook.so -- ../Tests/simpleFunc
