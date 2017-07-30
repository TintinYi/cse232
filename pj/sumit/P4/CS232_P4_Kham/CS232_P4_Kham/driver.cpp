/****************************************************************************************
//
//	File Name:				driver.cpp	
//	
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				The program is to compress a file using 
							a Huffman code and to decompress a file generated using this code
//
//	Date created:			05_10_2015
//
//	Date last modified:		05_10_2015
//
****************************************************************************************/
#include <iostream>
#include <string>
#include "huffman.h"
#include "Tree.h"
#include <fstream>
using namespace std;
int main()
{

	string oriFileName;
	string encodeFileName;
	string decodeFileName;
	ifstream infile;
	bool flag = true;
	char order;

	Huffman huffman;

	while (flag) {
		cout << "Command: 1.Encode 2.Decode 3.Quit" << endl;
		cin >> order;
		switch (order) {
			case '1':

				//cout << "Please input the filename:";
				cout << "Please input the graph file name(absolute path):";
				cin >> oriFileName;
				infile.open(oriFileName);
				//oriFileName = "jenny.txt";
				huffman.ReadTextFromFile(oriFileName);
				cout << "Print origin text:" << endl;
				huffman.CountCharsWeight();


				//cout << "Please input the filename:";
				//cin >> oriFileName;
				//oriFileName = "MyMessage.txt";
				//huffman.ReadTextFromFile(oriFileName);
				//cout << "Print origin text:" << endl;
				//huffman.CountCharsWeight();

				cout << "Print the char weight:" << endl;
				huffman.PrintCharWeight();
				cout << endl;

				huffman.MakeCharMap();
				cout << "Char and its encoding:" << endl;
				huffman.PrintCharCode();
				cout << endl;

				cout << "Encoding with origin text:" << endl;
				cout << "Origin text:" << endl;
				huffman.PrintText();
				huffman.Encode();
				cout << "Encoding:" << endl;
				huffman.PrintCode();

				cout << "Please input the filename to save encode:";
				cin >> encodeFileName;
				encodeFileName = "code.txt";
				huffman.SaveCodeToFile(encodeFileName);
				cout << endl;
				cout << "\nDone!" << endl;
				break;
			case '2':
				cout << "Decoding with file:" << endl;
				cout << "Please input the file to decode:";
				cin >> decodeFileName;
				decodeFileName = "code.txt";
				huffman.ReadCodeFromFile(decodeFileName);
				cout << "Decoding:" << endl;
				huffman.PrintCode();
				huffman.Decode();
				cout << "Origin text:" << endl;
				huffman.PrintText();
				// huffman.SaveTextToFile("resulttext.txt");
				cout << "\nDone!" << endl;
				break;
			case '3':
				flag = false;
				break;
			default:
				flag = false;
				break;
		}
	}
	return 0;
}