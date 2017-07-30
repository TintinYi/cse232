//****************************************************************************************
//
//	File Name:				lab7_driver.cpp	
//	
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				correcting class 
//							
//
//	Date created:			03_13_2015
//
//	Date last modified:		03_16_2015
//
//****************************************************************************************

#include <iostream>
#include "L7.h"

using namespace std;

int  main() {
	B<int> x;       // variable x is declared to be an instance of class A.

	int q;
	cout << "Set B:" << endl;
	cin >> q;
	x.set(q);

	x.f(); //  call public function f

	C<int> c;

	cout << "Set C:" << endl;;
	cin >> q;
	c.set(q);

	c.f();
	cin >> q;
	return 0;
}