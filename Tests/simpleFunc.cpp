// Exp Example

#include <iostream>
#include <cmath>
#include <cstring>
#include <dlfcn.h>
#include <iomanip>
#include <array>

void calcFunc(double *array, int s);

using namespace std;

int main()
{
	double x;
	int numElem =10;
	//cout << "main() Function... " << endl;
	//cout << "Calculation of exp(x)." << endl << "Give number of elements: ";
	//cin >> numElem;
	//double* array = new int[numElem];
	//array = {1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0};
	double array[10] = {1,2,3,4,5,6,7,8,9};
	double *pArray;
	pArray = array;
	/*
	for (int i=0; i< numElem; i++)
	{
		cout << "Give element " << (i+1) << ": ";
		cin >> array[i];
	}
	cout << endl;
	*/
	calcFunc(array, numElem);
	cout << endl << "Dummy program finished." << endl;
	//delete[] array;
	return 0;
}

// ----------
// Functions
// ----------

void calcFunc(double *array, int s)
{
	double expArray [s];
	double sinArray [s];
	double cosArray [s];

        //exp(19);

	for(int i = 0; i < s; i++)
	{
		if (i==0 || i==3 || i==6)
		{
			expArray[i] = exp(array[i]);
		}
		if (i==1 || i==4 || i==7)
		{
  			sinArray[i] = sin(array[i]);
		}
		if (i==2 || i==5 || i==8)
		{
			cosArray[i] = cos(array[i]);
		}
	}
	cout << setw(20) << left << "Value" << setw(20) << left << "Function"
	<< setw(20) << left << "Result" << endl;
	cout << "----------------------------------------------------" << endl;
	/*
	for(int i = 0; i < s; i++)
	{
		//double val = exp(array[i]);
		cout << setw(20) << left << array[i] << setw(10) << left
		<< expArray[i] << endl;
	}*/
	for(int i = 0; i < s; i++)
	{
		if (i==0 || i==3 || i==6)
		{
			cout << setw(20) << left << array[i] << setw(20)
			<< left << "exp" << setw(10)
			<< left << expArray[i] << endl;
		}
		if (i==1 || i==4 || i==7)
		{
  			cout << setw(20) << left << array[i] << setw(20)
			<< left << "sin" << setw(10)
			<< left << sinArray[i] << endl;
		}
		if (i==2 || i==5 || i==8)
		{
			cout << setw(20) << left << array[i] << setw(20)
			<< left << "cos" << setw(10)
			<< left << cosArray[i] << endl;
		}
	}
}
