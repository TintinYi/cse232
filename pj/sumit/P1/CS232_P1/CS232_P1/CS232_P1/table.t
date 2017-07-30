/**************************************************************************************************
*
*   File name :			table.t
*
*   This program		interface- function implementations 
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
//	Function name:	print
//	Purpose:		hash table
//	Input:			None
//	Output:			table
//	Return type:	void
//*****************************************************************************************
template <class Key, typename T>
void Table<Key, T>::print()
{
	Pair<Key, T> keyAndValue;
	for (int i = 0; i < tableSize; i++)
	{
		keyAndValue = the_table[i];
		Key key = keyAndValue.first;
		T value = keyAndValue.second;
		cout << i + 1 << ": {currentState:" << key.first;
		cout << ", input:" << key.second;
		cout << ", nextState:" << value.first;
		cout << ", action:" << value.second << "}" << endl;
	}
	
}
//*****************************************************************************************
//	Function name:	table
//	Purpose:		hash table
//	Input:			None
//	Output:			None
//	Return type:	void
//*****************************************************************************************
template <class Key, typename T>
Table<Key, T>::Table(int n, int(*map)(Key k))
{
	tableSize = n;
	the_table = new Pair<Key, T>[tableSize];
	memset(the_table, 0, sizeof(T) * tableSize);
	Mapping = map;
}

//*****************************************************************************************
//	Function name:	insert
//	Purpose:		
//	Input:			Pair
//	Output:			void
//	Return type:	bool
//*****************************************************************************************
template <class Key, typename T>
bool Table<Key, T>::insert(Pair<Key, T>  kvpair)
{
	Key key = kvpair.first;
	T value = kvpair.second;
	int index = (*Mapping)(key);
	the_table[index] = kvpair;
	return true;
}

//*****************************************************************************************
//	Function name:	remove
//	Purpose:		
//	Input:			Key
//	Output:			None
//	Return type:	bool
//*****************************************************************************************
template <class Key, typename T>
bool Table<Key, T>::remove(Key keyType)
{
	int index = (*Mapping)(keyType);
	Pair<Key, T> temp;
	the_table[index] = temp;
}

//*****************************************************************************************
//	Function name:	lookUp
//	Purpose:		
//	Input:			Key
//	Output:			None
//	Return type:	T
//*****************************************************************************************
template <class Key, typename T>
T  Table<Key, T>::lookUp(const Key aKey)
{
	int index = (*Mapping)(aKey);
	return the_table[index].second;
}

#endif