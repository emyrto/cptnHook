#**cptnHook**


##Abstract

cptnHook is a tool which is able to display the values of the arguments passed 
to mathematical functions in a scientific application (currently exp(x), 
sqrt(x), sin(x), cos(x), tan(x), asin(x), acos(x), atan(x)).

The initiative to build such a tool is based on the pressing need optimize 
scientific programs.
In more detail, the extensive use of transcendental mathematical functions in 
scientific applications leads to them accounting for a big portion of the 
programs' runtime. 

The objective is to achieve a drastic optimization of such programs with ad hoc 
approximations of the mentioned mathematical functions (e.g. polynomial 
approximations, Pade's approximation). The approximations will depend on the 
needed precision of the result and the domain of the input parameter.

To achieve this goal it's necessary to have a clear overview of the usage of 
the mathematical functions in the program. For this purpose the present tool 
has been implemented. cptnHook provides a measurement of the use of 
mathematical functions in a program without modifying the application's source 
code but rather by hooking into the machine code and probing the arguments of 
the functions.

cptnHook has been implemented with C++ and uses PIN 
(https://software.intel.com/en-us/articles/pintool) - a dynamic binary 
instrumentation framework that enables the creation of dynamic program analysis 
tools - for the purposes of probing the values inserted in mathematical functions 
and obtaining the stack trace of each mathematical function that is used. 
The tool is still in beta stage and further development is taking place.

The outputs of the tool are provided in ROOT (https://root.cern.ch/drupal/) format for further on analysis.


##Istallation

###Prerequisites:

1.	You need to download PIN

    go here: https://software.intel.com/en-us/articles/pin-a-binary-instrumentation-tool-downloads
    
    and download the appropriate version for LINUX according to your compiler.

2.	set PINDIR as the path to the place where PIN was built:

    `PINDIR=[path]`

    `export $PINDIR`

3.	You need to install ROOT

    go here: https://root.cern.ch/drupal/
    
    for further documentation on how to install ROOT

###Steps:

1. Run the getStarted.sh file with the following command

    `sh getStarted.sh`
  
  This file will generate all required files and will construct a library called "libcptnHook.so" which you will later on   use to hook your program.

2. You may now run this library along an example that exists in the folder Tests. Simply run the script
  "Compile_and_Run_Test.sh" with the following command:

    `sh Compile_and_Run_Test.sh`

  In order to use the library along a program name "myProg.cpp" you need to first compile it:
  
    `g++ -o myProg myProg.cpp`
    
  and then run it alongside PIN and the cptnHook library:
  
    `$PINDIR/pin -t libcptnHook.so -- ../myProg`
