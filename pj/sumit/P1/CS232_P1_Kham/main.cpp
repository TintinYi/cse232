/**************************************************************************************************
*
*   File name :			main.cpp
*
*   This program		Given a four button, five character combination lock;
*						a program which will simulate the behavior of the lock when five 
*						characters are entered. The actions are unlock (if correct sequence
*						entered ) and an alarm ( if the incorrect sequence is entered )
*						A table ADT must be used to store the transition table and action 
*						table of the finite state machine (FSN) which models the behavior of 
*						the lock. The correct combination will be given in a file
*						
*
*
*   Programmer:  		Sai Sao Kham
*
*   Date Written:		02/03/2015
*
*   Date Last Revised:	02/03/2015
*
***************************************************************************************************/

#include "table.h"
#include <iostream>
#include <string>
#include <Windows.h>
using namespace std;

#define SIZE 35

//*****************************************************************************************
//	Function name:	HashFunc
//	Purpose:		track array index for storage
//	Input:			None
//	Output:			None
//	Return type:	int
//*****************************************************************************************


int stateWithInputMap(Pair<string, char> key)//map fun
{
	int int1;
	string str1 = key.first;//current state	
	char ch1 = key.second; // input char

	if ("nke" == str1){ int1 = 0; }
	else if ("ok1" == str1){ int1 = 5; }
	else if ("ok2" == str1){ int1 = 10; }
	else if ("ok3" == str1){ int1 = 15; }
	else if ("fa1" == str1){ int1 = 20; }
	else if ("fa2" == str1){ int1 = 25; }
	else if ("fa3" == str1){ int1 = 30; }

	return int1 + ch1 % 65;//track index
}

int main()
{
	// variables initial
	int b;
	string currentState;
	string nextState;
	string action;
	char input;
	Table<Pair<string, char>, Pair<string, string>> FSM(SIZE, stateWithInputMap);

	// initial actionTable
	FSM.insert(makePair(makePair(currentState = "nke", input = 'A'), makePair(nextState = "fa1", action = "")));
	FSM.insert(makePair(makePair(currentState = "nke", input = 'B'), makePair(nextState = "ok1", action = "")));
	FSM.insert(makePair(makePair(currentState = "nke", input = 'C'), makePair(nextState = "fa1", action = "")));
	FSM.insert(makePair(makePair(currentState = "nke", input = 'D'), makePair(nextState = "fa1", action = "")));
	FSM.insert(makePair(makePair(currentState = "nke", input = 'E'), makePair(nextState = "fa1", action = "")));

	FSM.insert(makePair(makePair(currentState = "ok1", input = 'A'), makePair(nextState = "ok2", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok1", input = 'B'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok1", input = 'C'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok1", input = 'D'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok1", input = 'E'), makePair(nextState = "fa2", action = "")));

	FSM.insert(makePair(makePair(currentState = "ok2", input = 'A'), makePair(nextState = "ok3", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok2", input = 'B'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok2", input = 'C'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok2", input = 'D'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "ok2", input = 'E'), makePair(nextState = "fa3", action = "")));

	FSM.insert(makePair(makePair(currentState = "ok3", input = 'A'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "ok3", input = 'B'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "ok3", input = 'C'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "ok3", input = 'D'), makePair(nextState = "nke", action = "unlock")));
	FSM.insert(makePair(makePair(currentState = "ok3", input = 'E'), makePair(nextState = "nke", action = "alarm")));

	FSM.insert(makePair(makePair(currentState = "fa1", input = 'A'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa1", input = 'B'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa1", input = 'C'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa1", input = 'D'), makePair(nextState = "fa2", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa1", input = 'E'), makePair(nextState = "fa2", action = "")));

	FSM.insert(makePair(makePair(currentState = "fa2", input = 'A'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa2", input = 'B'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa2", input = 'C'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa2", input = 'D'), makePair(nextState = "fa3", action = "")));
	FSM.insert(makePair(makePair(currentState = "fa2", input = 'E'), makePair(nextState = "fa3", action = "")));

	FSM.insert(makePair(makePair(currentState = "fa3", input = 'A'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "fa3", input = 'B'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "fa3", input = 'C'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "fa3", input = 'D'), makePair(nextState = "nke", action = "alarm")));
	FSM.insert(makePair(makePair(currentState = "fa3", input = 'E'), makePair(nextState = "nke", action = "alarm")));

	FSM.print();

	// Please input:
	string stage = "nke";
	string next;
	string act;
	Pair<string, char> p;
	Pair<string, string> result;
	char ch;
	bool flag = false;
	while(!flag) {
		// If lock is still locked, do the while until reach unlocked.

		cout << "\nPlease input the char:";
		cin >> ch;
		ch = toupper(ch);

		p = makePair(stage, ch);
		result = FSM.lookUp(p);

		next = result.first;
		act = result.second;

		cout << "result: NEXT-STAGE:" << next << " ACTION:" << act << endl; 
		
		if (act.compare("unlock") == 0) {
			flag = true;
		} else if (act.compare("alarm") == 0) {
			cout << endl << "WRONG PASSWD!" << endl;
			Beep( 750, 300 );
		} else {
			cout << "" << endl;
		}
		stage = next;
	}

	// while flag becomes true, means unlocked
	cout << "UNLOCK!" << endl;
	cin >> b;

	return 0;
}