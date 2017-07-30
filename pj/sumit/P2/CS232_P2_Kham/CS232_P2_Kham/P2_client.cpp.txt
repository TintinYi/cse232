//****************************************************************************************
//
//	File Name:				P2_client.cpp	
//	
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				print graph, DFT, BFT according to inputs
//							and from txt file
//
//	Date created:			03_19_2015
//
//	Date last modified:		03_23_2015
//
//****************************************************************************************
#include "P2_1.h"
#include <iostream>
using namespace std;
int main()

{
	char c;
	Graph<string, int> graphReadTest, graphDFTTest, graphBFTTest;

	cout << endl << "***** Read Map From File *****" << endl;
	graphReadTest.GetGraph();

	cout << "Print Graph:\n\n" ;
	graphReadTest.SimplePrintGraph();

	cout << endl << "Shortest Path:" << endl;

	string startV,desV;
	cout << "Where you wanna start: ";
	cin >> startV;
	
	cout << "Where you wanna stop: ";
	cin >> desV;
	cout << endl;
	
	cout << graphReadTest.ShortestDistance(startV, desV) << endl;

	string verte;
	graphDFTTest.GetGraph();
	cout << "\nDFT:\n";
	cout << "Where you wanna start for DFT: ";
	cin >> verte;
	cout  << "\nBEGIN ->";
	graphDFTTest.DFTraversal(verte);
	cout  << "STOP\n\n";

	string start;
	graphBFTTest.GetGraph();
	cout <<"\nBFT:\n";
	cout << "Where you wanna start for BFT: ";
	cin >> start;
	cout << "\nBEGIN -> ";
	graphBFTTest.BFTraversal(start);
	cout << "STOP" << endl;
	
	cin >> c;
	return 0;
}