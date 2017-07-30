/**************************************************************************************************
*
*   File name :			table.h
*
*   This program		function prototypes 
*
*
*   Programmer:  		Sai Sao Kham
*
*   Date Written:		02/03/2015
*
*   Date Last Revised:	02/03/2015
*
***************************************************************************************************/


#ifndef TABLE_H
#define TABLE_H

//*****************************************************************************************
//	Function name:	
//	Purpose:		Constructor
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************

template < typename keyType, typename valType >
struct pair
	{
		keyType key;
		valType value;
	
	};

//*****************************************************************************************
//	Function name:	class table	
//	Purpose:		
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************


template < typename keyType, typename valType >
class table
{
	public:
	int SIZE = 9;	
	pair arr[SIZE];
	int(*hashFunction)(keyType,valType);

	table();
	table(int(*h)(keyType,valType));
	~table();
	void insert(keyType,valType);
	bool remove(keyType);
	bool full();
	bool empty();	

};
//********************************************************



#include "table.t"

#endif