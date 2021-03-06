# Interceptor Generator
# Writes all PIN interceptor functions
# & includes ""pin.H" and writes all complementary PIN functions
#print ("Interceptor Generator")

# --------------------------------------------------------------------------- #
#                                DECLARATIONS                                 #
# --------------------------------------------------------------------------- #

funcList = ["exp", "sqrt", "sin", "cos", "tan", "asin", 	\
            "acos", "atan"]

declaration1 = '#define %s "_%s"'
declaration2 = '#define %s "%s"'

script = 'RTN %sRtn = RTN_FindByName(img, %s); \n\
	if (RTN_Valid(%sRtn)) \n\
	{ \n\
		RTN_Open(%sRtn); \n\
		\n\
		// Instrument %s() to print the input argument value and the \n\
		// return value.\n\
		RTN_InsertCall(%sRtn, IPOINT_BEFORE, (AFUNPTR)Arg1Before, IARG_ADDRINT,\n\
		               %s,IARG_FUNCARG_ENTRYPOINT_VALUE, 0, IARG_END); \n\
		\n\
		TraceFile << "Function: %s" << endl<< "stack: "<< endl << Backtrace(skip=1) << endl; \n\
		TraceFile << "%sRtn ID: " << std::dec << LEVEL_PINCLIENT::RTN_No(%sRtn) << endl; \n\
		TraceFile << "--------------------------------------------------------------------------------" << endl; \n\
		RTN_Close(%sRtn); \n\
	}'

# --------------------------------------------------------------------------- #
#                             MAIN BODY OF HEADER                             #
# --------------------------------------------------------------------------- #

print '#include "pin.H"'

print "//Declaration of Pin Interceptors."
print '#if defined(TARGET_MAC)'
for func in funcList:
	print declaration1 %(func.upper(), func)

print '#else'
for func in funcList:
	print declaration2 %(func.upper(), func)

print '#endif'

print "\n"
print "int skip = 1; \n\
int expCntr = 0; \n\
int sqrtCntr = 0; \n\
int sinCntr = 0; \n\
int cosCntr = 0; \n\
int tanCntr = 0; \n\
int asinCntr = 0; \n\
int acosCntr = 0; \n\
int atanCntr = 0; \n\
std::vector<int> callCntr = {0,0,0,0,0,0,0,0}; \n\
std::string Backtrace(int skip); \n\
std::string rtnStack;"

print "\n"
print '/* ========================================================================= */\n\
/* Commandline Switches                                                      */\n\
/* ========================================================================= */\n\
KNOB<string> KnobOutputFile(KNOB_MODE_WRITEONCE, "pintool","o", "dataTree.txt",\n "specify trace file name");'


print "\n"
print '/* ========================================================================= */\n\
/* Analysis routines                                                         */\n\
/* ========================================================================= */\n\
VOID Arg1Before(CHAR* name, double a)//CHAR * name, ADDRINT size)\n\
{\n\
	int rtnID; \n\
	std::string str(name); \n\
	if (str == "exp") rtnID = 0; //2869; \n\
	if (str == "sqrt") rtnID = 1; //2889; \n\
	if (str == "sin") rtnID = 2; //2858; \n\
	if (str == "cos") rtnID = 3; //2857; \n\
	if (str == "tan") rtnID = 4; //2860; \n\
	if (str == "asin") rtnID = 5; //2864; \n\
	if (str == "acos") rtnID = 6; //2862; \n\
	if (str == "atan") rtnID = 7; //2837; \n\
	\n\
	switch (rtnID)\n\
	{\n\
		case 0:\n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of exp: " << expCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			expCntr++;\n\
			break;\n\
		case 1: \n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of sqrt: " << sqrtCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			sqrtCntr++;\n\
			break;\n\
		case 2: \n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of sin: " << sinCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			sinCntr++;\n\
			break;\n\
		case 3: \n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of cos: " << cosCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			cosCntr++;\n\
			break;\n\
		case 4: \n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of tan: " << tanCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			tanCntr++;\n\
			break;\n\
		case 5: \n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of asin: " << asinCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			asinCntr++; \n\
			break; \n\
		case 6:\n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1);\n\
			cout << "Stack of acos: " << acosCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			acosCntr++; \n\
			break; \n\
		case 7: \n\
			rtnStackVector[rtnID][expCntr]=Backtrace(skip=1); \n\
			cout << "Stack of atan: " << atanCntr << " is: " << endl << rtnStackVector[rtnID][expCntr] << endl; \n\
			atanCntr++; \n\
			break; \n\
	}\n\
	TraceFile << "Function: " << name << "\t value: " << a << endl;\n\
	treeFill(a, rtnID, callCntr[rtnID]); \n\
	callCntr[rtnID]++; \n\
}\n\
\n\
VOID FuncAfter(ADDRINT ret)\n\
{\n\
	TraceFile << "  returns " << (double*)ret << endl;\n\
}'

print "\n"
print "/* ========================================================================= */\n\
/* Instrumentation routines                                                  */\n\
/* ========================================================================= */"
print "VOID Image(IMG img, VOID *v) \n{"
for i,func in enumerate(funcList):
	print "	",script %(func, func.upper(), func, func, func, func, func.upper(), func, func, func, func), "\n"
print "}"

print "\n"
print '/* ========================================================================= */\n\
/* Fini Function			                                     */\n\
/* ========================================================================= */\n\
\n\
VOID Fini(INT32 code, VOID *v)\n\
{\n\
	TraceFile.close();\n\
	\n\
	fPntr->WriteObject(&stackVector, "stackVector");\n\
	fPntr->Write();\n\
	fPntr->Close();\n\
}'
print "\n"
print '/* ========================================================================= */\n\
/* Print Help Message                                                        */\n\
/* ========================================================================= */\n\
\n\
INT32 Usage()\n\
{\n\
    cerr << "This tool produces a trace of calls to mathematical functions." \n\
	 << endl;\n\
    cerr << endl << KNOB_BASE::StringKnobSummary() << endl;\n\
    return -1;\n\
}'
print "\n"
print '/* ========================================================================= */ \n\
/* Backtrace Function                                                        */ \n\
/* ========================================================================= */ \n\
\n\
std::string Backtrace(int skip = 1) \n\
{ \n\
	void *callstack[128]; \n\
	const int nMaxFrames = sizeof(callstack) / sizeof(callstack[0]); \n\
	char buf[1024]; \n\
	int nFrames = backtrace(callstack, nMaxFrames); \n\
	char **symbols = backtrace_symbols(callstack, nFrames); \n\
 \n\
	std::ostringstream trace_buf; \n\
	for (int i = skip; i < nFrames; i++)  \n\
	{ \n\
		Dl_info info; \n\
		if (dladdr(callstack[i], &info) && info.dli_sname)  \n\
		{ \n\
			char *demangled = NULL; \n\
			int status = -1; \n\
			if (info.dli_sname[0] == \'_\') \n\
				demangled = abi::__cxa_demangle(info.dli_sname, \n\
				NULL, 0, &status); \n\
			snprintf(buf, sizeof(buf), "%-3d %*p %s + %zd\\n", \n\
				i, int(2 + sizeof(void*) * 2), \n\
				callstack[i], \n\
				status == 0 ? demangled : \n\
				info.dli_sname == 0 ? \n\
				symbols[i] : info.dli_sname, \n\
				(char *)callstack[i] - (char \n\
				*)info.dli_saddr); \n\
			free(demangled); \n\
		}  \n\
		else  \n\
		{ \n\
			snprintf(buf, sizeof(buf), "%-3d %*p %s\\n", \n\
				i, int(2 + sizeof(void*) * 2), \n\
				callstack[i], symbols[i]); \n\
		} \n\
                trace_buf << buf; \n\
        } \n\
	free(symbols); \n\
	if (nFrames == nMaxFrames) \n\
		trace_buf << "[truncated]\\n"; \n\
	return trace_buf.str(); \n\
}'
