#ifndef MYPINHOOKROOT_H
#define MYPINHOOKROOT_H

/* ========================================================================= */
/* Headers                                                                   */
/* ========================================================================= */
// C++
#include <iostream>
#include <fstream>
#include <vector>
#include <map>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <cstring>
#include <sstream>
#include <execinfo.h>   // for backtrace
#include <dlfcn.h>      // for dladdr
#include <cxxabi.h>     // for __cxa_demangle
#include <unistd.h>
#include <assert.h>

// ROOT
#include "TROOT.h"
#include "TFile.h"
#include "TTree.h"
#include "TBrowser.h"
#include "TH2.h"
#include "TStorage.h"
#include "TObject.h"

/* ========================================================================= */
/* Globals                                                                   */
/* ========================================================================= */
// Variables
std::ofstream TraceFile;
FILE* cctlibOutputFile;

bool initializedTree = false;
static float valExp, valSqrt, valSin, valCos, valTan, valAsin, valAcos, valAtan;
static ULong64_t hashExp, hashSqrt, hashSin, hashCos, hashTan, hashAsin, hashAcos, hashAtan;
static ULong64_t ihExp=-1;
static ULong64_t ihSqrt=-1;
static ULong64_t ihSin=-1;
static ULong64_t ihCos=-1;
static ULong64_t ihTan=-1;
static ULong64_t ihAsin=-1;
static ULong64_t ihAcos=-1;
static ULong64_t ihAtan=-1;
//std::unordered_map <std::string, ULong64_t> myMap;
std::map <std::string, ULong64_t> myExpMap;
std::map <std::string, ULong64_t> mySqrtMap;
std::map <std::string, ULong64_t> mySinMap;
std::map <std::string, ULong64_t> myCosMap;
std::map <std::string, ULong64_t> myTanMap;
std::map <std::string, ULong64_t> myAsinMap;
std::map <std::string, ULong64_t> myAcosMap;
std::map <std::string, ULong64_t> myAtanMap;
std::vector<std::string> stackVector;
std::vector<std::string> stackExpVector;
std::vector<std::string> stackSqrtVector;
std::vector<std::string> stackSinVector;
std::vector<std::string> stackCosVector;
std::vector<std::string> stackTanVector;
std::vector<std::string> stackAsinVector;
std::vector<std::string> stackAcosVector;
std::vector<std::string> stackAtanVector;

//std::vector<std::string> rtnStackVector (10);
//static std::string dummyStr;
//std::vector<int> addressVector;
std::vector<std::vector<std::string>> rtnStackVector(10, std::vector<std::string>(10," "));
//vector<pair<int,string>> funcIdAndStackVector;

//int i = 0;
//std::vector<int> rtnIDs;

// Functions
//ULong64_t myHash(std::string s, std::unordered_map <std::string, ULong64_t>& myMap, Int_t& ih);
ULong64_t myHash(const std::string& s, std::map <std::string, ULong64_t>& myMap, ULong64_t& ih);
static void initializeTree (void);
void treeFill(double x, int rtnID, int rtnEnum);//, std::string stackRtn); //, ADDRINT addr);

// Root TFile, TTree
TFile * fPntr = new TFile("dataTree.root", "recreate");
//auto* fPntr = new TFile("dataTree.root", "recreate");
TTree * treeExpPntr = new TTree("treeExp", "Tree with data from the exp(x) function");
TTree * treeSqrtPntr = new TTree("treeSqrt", "Tree with data from the sqrt(x) function");
TTree * treeSinPntr = new TTree("treeSin", "Tree with data from the sin(x) function");
TTree * treeCosPntr = new TTree("treeCos", "Tree with data from the cos(x) function");
TTree * treeTanPntr = new TTree("treeTan", "Tree with data from the tan(x) function");
TTree * treeAsinPntr = new TTree("treeAsin", "Tree with data from the asin(x) function");
TTree * treeAcosPntr = new TTree("treeAcos", "Tree with data from the acos(x) function");
TTree * treeAtanPntr = new TTree("treeAtan", "Tree with data from the atan(x) function");

#endif
