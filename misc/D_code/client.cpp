#include "pj2_1.h"
#include <iostream>
using namespace std;
int main()

{
	char c;
	Graph<string, int> graphReadTest, graphDFTTest, graphBFTTest;

	cout << endl << "Read Map From File:" << endl;
	graphReadTest.GetGraph();

	cout << endl << "Print Graph:" << endl;
	graphReadTest.SimplePrintGraph();

	cout << endl << "Shortest Path:" << endl;
	string startV;
	cout << "Where you wanna start: ";
	cin >> startV;
	string desV;
	cout << "Where you wanna stop: ";
	cin >> desV;
	cout << endl;
	
	cout << graphReadTest.ShortestDistance(startV, desV) << endl;



	string verte;
	graphDFTTest.GetGraph();
	cout << "Where you wanna start: ";
	cin >> verte;
	cout << endl << "DFT Begin:" << endl << "BEGIN->";
	graphDFTTest.DFTraversal(verte);
	cout  << "STOP" << endl;




	string start;
	graphBFTTest.GetGraph();
	cout << "Where you wanna start: ";
	cin >> start;
	cout << endl << "BFT Begin:" << endl << "BEGIN->";
	graphBFTTest.BFTraversal(start);
	cout << "STOP" << endl;
	

	cin >> c;
	return 0;
}