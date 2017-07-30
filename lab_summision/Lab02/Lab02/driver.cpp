/**************************************************************************************************
*
*   File name :			driver.cpp
*
*   This program		table function by using fuction pointers and hash
*
*
*   Programmer:  		Sai Sao Kham
*
*   Date Written:		02/03/2015
*
*   Date Last Revised:	02/03/2015
*
***************************************************************************************************/

#include<iostream>
using std::cin;
using std::cout;
//using std::cerr;
using std::endl;

#include "table.h"

//*****************************************************************************************
//	Function name:	H
//	Purpose:		track array index for storage
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************
int H(int key,int val)
{

	return (key%9);
}

int main()
{
	table<int,int> T1(H);
	

	return 0;
}