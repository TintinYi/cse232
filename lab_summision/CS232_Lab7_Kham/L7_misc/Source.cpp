//****************************************************************************************
//
//	File Name:				lab7_driver.cpp	
//	
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				derived class 
//							
//
//	Date created:			03_13_2015
//
//	Date last modified:		03_16_2015
//
//****************************************************************************************

#include <iostream>
using namespace std;

class A {
	protected:
		int  number;
};
class B : public A {
	public: void f()
	{
		cout << "From derived class, number is: " << number << endl; 
	}
};
int  main() {
	B x;       // variable x is declared to be an instance of class A.
	int k;
	cout << endl  << endl  <<  "Lab Demo Program" << endl;
	cout <<   "The number is: "  <<  k << endl;
	x.f(); //  call public function f
	return 0;
}