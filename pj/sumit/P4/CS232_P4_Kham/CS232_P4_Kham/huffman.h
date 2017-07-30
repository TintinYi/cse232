
/****************************************************************************************
//
//	File Name:				huffman.h	
//	
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				Huffman.h: interface for the Huffman class. inputs
//							and from txt file
//
//	Date created:			05_10_2015
//
//	Date last modified:		05_10_2015
//
****************************************************************************************/

#ifndef HUFFMAN_H__
#define HUFFMAN_H__

#include <string>
#include <fstream>
#include <iostream>
using namespace std;

typedef struct 
{
	unsigned int weight;
	unsigned int parent;
	unsigned int lchild;
	unsigned int rchild;
}HuffTreeNode,*HuffTree;

typedef struct
{
	char c;
	unsigned int weight;
	char *code;
}CharMapNode,*CharMap;

class Huffman  
{
private:
	void select(int n, int &s1, int &s2);
	HuffTree huffTree;
	CharMap chars;
	int n;
	std::string text;
	std::string code;
public:	
	void CountCharsWeight();
	void Decode();
	void ReadTextFromFile(string filename);
	void ReadCodeFromFile(string filename);
	void SaveTextToFile(string filename);
	void SaveCodeToFile(string filename);
	void PrintCode();
	void MakeCharMap();
	void PrintText();	
	void PrintCharCode();
	void PrintCharWeight();
	void SetCharMap(CharMap m, int number);
	void Encode();
	Huffman();
	virtual ~Huffman();
};
//**************************************************************
//	Function name:	Huffman()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////
Huffman::Huffman()
{
	huffTree = NULL;
	chars = NULL;
	n = 0;
}

//**************************************************************
//	Function name:	~Huffman()
//	Purpose:		deconstructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
Huffman::~Huffman()
{
}

//**************************************************************
//	Function name:	Encode()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::Encode()
{
	code = "";
	for (string::size_type i = 0; i != text.size(); ++i)
	{
		for (int j = 1; j <= n; ++j)
			if (chars[j].c == text[i])
				code += chars[j].code;
	}
}

//**************************************************************
//	Function name:	SetCharMap()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::SetCharMap(CharMap m, int number)
{
	chars = m;
	n = number;
}

//**************************************************************
//	Function name:	select()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::select(int n, int &s1, int &s2)
{
	s1 = s2 = 0;
	for (int i = 1; i <= n; ++i)
	{
		if (huffTree[i].parent != 0)
			continue;
		if (s1 == 0)
			s1 = i;
		else if (s2 == 0)
		{
			if (huffTree[i].weight < huffTree[s1].weight)
			{
				s2 = s1;
				s1 = i;
			}
			else
				s2 = i;
		}
		else
		{
			if (huffTree[i].weight < huffTree[s1].weight)
			{
				s2 = s1;
				s1 = i;
			}
			else if (huffTree[i].weight < huffTree[s2].weight)
				s2 = i;
		}
	}
}

//**************************************************************
//	Function name:	PrintCharWeight()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::PrintCharWeight()
{
	for (int i = 1; i <= n; ++i)
	{
		cout << chars[i].c << " " << chars[i].weight << endl;
	}
}

//**************************************************************
//	Function name:	PrintCharCode()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::PrintCharCode()
{
	for (int i = 1; i <= n; ++i)
	{
		// switch (chars[i].c)
		// {
		// case '/t':
		// 	cout << "/t";
		// 	break;
		// case '/n':
		// 	cout << "/n";
		// 	break;
		// default:
		// 	cout << chars[i].c;
		// 	break;
		// }
		// 	cout << "  " << chars[i].code << endl;
		cout << chars[i].c << " " << chars[i].code << endl;
	}
}

//**************************************************************
//	Function name:	PrintText()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::PrintText()
{
	cout << text << endl;
}

//**************************************************************
//	Function name:	PrintCode()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::PrintCode()
{
	cout << code << endl;
}

//**************************************************************
//	Function name:	MakeCharMap()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::MakeCharMap()
{
	if (n <= 1)
		return;
	int m = 2 * n - 1;
	huffTree = new HuffTreeNode[m+1];
	int i;
	for (i = 1; i <= n; ++i)
	{
		huffTree[i].weight = chars[i].weight;
		huffTree[i].parent = 0;
		huffTree[i].lchild = 0;
		huffTree[i].rchild = 0;
	}
	for (i = n + 1; i <= m; ++i)
	{
		huffTree[i].weight = 0;
		huffTree[i].parent = 0;
		huffTree[i].lchild = 0;
		huffTree[i].rchild = 0;
	}
	for (i = n + 1; i <= m; ++i)
	{
		int s1,s2;
		select(i - 1, s1, s2);
		huffTree[s1].parent = huffTree[s2].parent = i;
		huffTree[i].lchild = s1;
		huffTree[i].rchild = s2;
		huffTree[i].weight = huffTree[s1].weight + huffTree[s2].weight;
	}
	char *cd = new char[n];
	cd[n-1] = '\0';
	for(i = 1; i <= n; ++i)
	{
		int start = n - 1;
		int c,f;
		for (c = i, f = huffTree[i].parent; f != 0; c = f, f = huffTree[f].parent)
		{
			if (huffTree[f].lchild == c)
				cd[--start] = '0';
			else
				cd[--start] = '1';
		}
		chars[i].code = new char[n - start];
		strcpy(chars[i].code,&cd[start]);
	}
	delete [] cd;
}

//**************************************************************
//	Function name:	ReadTextFromFile()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::ReadTextFromFile(string filename)
{
	ifstream infile(filename);
	if(!infile)
	{
		cerr << "Can not read the file!" <<endl;
		return;
	}
	char c;
	while(infile.get(c))
	{
		if (c == '*') {
			cout << text << endl;
			return;
		}
		text += c;
	}
}

//**************************************************************
//	Function name:	SaveCodeToFile()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::SaveCodeToFile(string filename)
{
	ofstream outfile(filename);
	if (!outfile)
	{
		cerr << "Can not open the file" << endl;
		return;
	}
	outfile << code;
}

//**************************************************************
//	Function name:	ReadCodeFromFile()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::ReadCodeFromFile(string filename)
{
	ifstream infile(filename);
	if (!infile)
	{
		cerr << "Can not open the file" <<endl;
		return;
	}
	infile >> code;
}

//**************************************************************
//	Function name:	Decode()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::Decode()
{
	text = "";
	string::size_type i,count;
	for (i = 0; i < code.size(); i += count)
	{
		for (count = 1; count < n; ++count)
		{
			for (int j = 1; j <= n; ++j)
				if (code.substr(i, count) == chars[j].code)
				{
					text += chars[j].c;
					goto next;
				}
		}
next:
		;
	}
}

//**************************************************************
//	Function name:	CountCharsWeight()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::CountCharsWeight()
{
	if (text.empty())
		return;
	if (chars != NULL)
		delete [] chars;
	int i = 0;
	n = 0;
	chars = new CharMapNode[2];
	chars[1].c = text[i];
	chars[1].weight = 1;
	++n;
	for (i = 1; i != text.size(); ++i)
	{
		int j;
		for (j = 1; j <= n; ++j)
		{
			if (text[i] == chars[j].c)
			{
				++chars[j].weight;
				break;
			}
		}
		if (j > n)
		{
			++n;
			CharMap newchars = new CharMapNode[n + 1];
			memcpy(newchars, chars, n * sizeof(CharMapNode));
			delete [] chars;
			chars = newchars;
			chars[n].c = text[i];
			chars[n].weight = 1;
		}
	}
}
//**************************************************************
//	Function name:	SaveTextToFile()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
void Huffman::SaveTextToFile(string filename)
{
	ofstream outfile(filename);
	if (!outfile)
	{
		cerr << "Can not open the file!" << endl;
		return;
	}
	outfile << text;
}

#endif
