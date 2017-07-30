/**************************************************************************************************
*
*   File name :			table.t
*
*   This program		interface- function implementations with generic data types
*
*
*   Programmer:  		Sai Sao Kham
*
*   Date Written:		02/03/2015
*
*   Date Last Revised:	02/03/2015
*
***************************************************************************************************/

#ifndef TABLE_T
#define TABLE_T
#include "table.h"

//*****************************************************************************************
//	Function name:	table
//	Purpose:		hash table
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************

	template < typename keyType, typename valType >
	table<keyType,valType>::table(int(*h)(keyType,valType))
	{
		hashFunction = h;
	}
//*****************************************************************************************
//	Function name:	insert
//	Purpose:		
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************

	template < typename keyType, typename valType >
	void table<keyType,valType>::insert(keyType,valType)
	{
	int index = hashFunction(keyType,valType);
	//make pair using keytype and valtype
	pair<keyType,valType> temp;
	temp.key = keyType;
	temp.value = valType;
	arr[index] = temp;
	
	}
//*****************************************************************************************
//	Function name:	remove
//	Purpose:		
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************

	template < typename keyType, typename valType >
	bool table<keyType,valType>::remove(keyType)
	{
	
	}
//*****************************************************************************************
//	Function name:	full()
//	Purpose:		identify full
//	Input:			None
//	Output:			None
//	Return type:	bool
//*****************************************************************************************

	template < typename keyType, typename valType >
	bool table<keyType,valType>::full()
	{
	
	}

//*****************************************************************************************
//	Function name:	empty
//	Purpose:		identify empty
//	Input:			None
//	Output:			None
//	Return type:	bool
//*****************************************************************************************

	template < typename keyType, typename valType >
	bool table<keyType,valType>::empty()
	{
	
	}


#endif