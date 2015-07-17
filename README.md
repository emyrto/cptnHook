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

cptnHook has been implemented with C++ and uses PIN - a dynamic binary 
instrumentation framework that enables the creation of dynamic program analysis 
tools - for the purposes of probing the values inserted in mathematical functions 
and obtaining the stack trace of each mathematical function that is used. 

The outputs of the tool are provided in ROOT format for further on analysis.
