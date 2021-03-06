//*************************************************************
//
//	File Name:				P2_1.t	
//
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				function implementation
//						
//
//	Date created:			03_19_2015
//
//	Date last modified:		03_23_2015
//
//**************************************************************
#ifndef P2_1_T
#define P2_1_T

#include <fstream>
#include <string>
#include <iostream>
#include <vector>

using namespace std;


//**************************************************************
//	Function name:	Graph()
//	Purpose:		constructor,initializing
//	Input:			None
//	Output:			None
//	Return type:	templated Graph
//**************************************************************
template <class V, class W>
Graph<V, W>::Graph()//constructor
{
	vertex<V, W> vex;
	vex.name = "empty";
	vex.visited = 0; // initial vertex without visited
	list< edgeRep<V, W> > egList;
	vex.edgelist = egList;
	for (int i = 0; i<MAX; i++) G[i] = vex;
	//cout << "Graph created!" << endl;
}

//**************************************************************
//	Function name:	~Graph
//	Purpose:		Destructor, to remove when ending
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
Graph<V, W>::~Graph()
{
	cout << "Graph deleted!" << endl;
}

//********************************************************************
//	Function name:	isVertex()
//	Purpose:		dividing arr size with edges to gets acurate size
//	Input:			None
//	Output:			None
//	Return type:	void
//*********************************************************************
template <class V, class W>
int Graph<V, W>::isVertex(V &v)
{
	int index = 0;
	for (; index < sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> vert = G[index];
		if (vert.name == v) return index;
	}
	return -1;
}

//**************************************************************
//	Function name:	isUniEdge()
//	Purpose:		assigning graph to one direcion 
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
int Graph<V, W> ::isUniEdge(V &v1, V &v2)
{
	int index = 0;
	for (; index <sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> vert = G[index];

		if (vert.name == v1) {
			list< edgeRep<V, W> >::iterator i;
			for (i = vert.edgelist.begin(); i != vert.edgelist.end(); i++) {
				edgeRep<V, W> eg = *i;
				if (eg.name == v2) return 1;
			}
		}
	}
	return 0;
}

//**************************************************************
//	Function name:	isBiDirEdge
//	Purpose:		assigning 2 directions nodes
//	Input:			None
//	Output:			None
//	Return type:	templated
//**************************************************************
template <class V, class W>
int Graph<V, W> ::isBiDirEdge(V &v1, V &v2)
{
	if (isUniEdge(v1, v2) && isUniEdge(v2, v1)) return 1;
	else return 0;
}

//**************************************************************
//	Function name:	AddVertex
//	Purpose:		loop each arr and find similar name, add if
//					doens't exist in arr
//	Input:			None
//	Output:			None
//	Return type:	templated
//**************************************************************
template <class V, class W>
int Graph<V, W> ::AddVertex(V &v)
{
	int index = 0;

	for (; index <sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> vert = G[index];
		if (vert.name == "empty") {
			vertex<V, W> vex;
			vex.name = v;
			vex.visited = 0;
			list< edgeRep<V, W> > edList;
			vex.edgelist = edList;
			G[index] = vex;
			return index;
		}
		else if (vert.name == v) return index;
	}
	vertex<V, W> vex;
	vex.name = v;
	vex.visited = 0;
	list< edgeRep<V, W> > edList;
	vex.edgelist = edList;
	G[index] = vex;
	return index;
}

//**************************************************************
//	Function name:	DeleteVertex()
//	Purpose:		deleting vertex and edges if connected 
//	Input:			None
//	Output:			None
//	Return type:	templated
//**************************************************************
template <class V, class W>
int Graph<V, W> ::DeleteVertex(V &v)
{
	int index = 0;

	for (; index <sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> vert = G[index];
		if (vert.name == v) {
			vertex<V, W> vex;
			vex.name = "empty";
			vex.visited = 0;
			list< edgeRep<V, W> > egList;
			vex.edgelist = egList;
			G[index] = vex;
			continue;
		}

		list< edgeRep<V, W> > egList = vert.edgelist;
		list< edgeRep<V, W> >::iterator i;
		for (i = egList.begin(); i != egList.end(); i++) {
			edgeRep<V, W> edg = *i;
			V endName = edg.name;
			W endWeight = edg.weight;
			if (endName == v) i = vert.erase(i);
		}
		G[index] = vert;
	}
}

//**************************************************************
//	Function name:	AddUniEdge()
//	Purpose:		adding edges as one direction
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
int Graph<V, W> ::AddUniEdge(V &v1, V &v2, W &wt)
{
	int index = 0;
	for (; index <sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> vert = G[index];

		if (vert.name == v1) {
			list< edgeRep<V, W> >::iterator i;
			for (i = vert.edgelist.begin(); i != vert.edgelist.end(); i++) {
				edgeRep<V, W> eg = *i;
				if (eg.name == v2) return 1;
			}
			edgeRep<V, W> egInsert;
			egInsert.name = v2;
			egInsert.weight = wt;
			vert.edgelist.push_back(egInsert);
			//cout << vert.name + " ";
			//cout << egInsert.name + " ";
			//cout << egInsert.weight << endl;
			G[index] = vert;
			return 1;
		}
	}
	return 0;
}

//**************************************************************
//	Function name:	DeleteUniEdge()
//	Purpose:		deleting edges but not vertex 
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
int Graph<V, W> ::DeleteUniEdge(V &v1, V &v2)
{
	int index = 0;

	for (; index <sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> vert = G[index];
		if (vert.name == v1) {
			list< edgeRep<V, W> > egList = vert.edgelist;
			list< edgeRep<V, W> >::iterator i;
			for (i = egList.begin(); i != egList.end(); i++) {
				edgeRep<V, W> edg = *i;
				V endName = edg.name;
				W endWeight = edg.weight;
				if (endName == v2) i = vert.erase(i);
			}
		}
		G[index] = vert;
	}
}

//**************************************************************
//	Function name:	AddBiDirEdge()
//	Purpose:		adding 2 directions between 2 vertex
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
int Graph<V, W> ::AddBiDirEdge(V &v1, V &v2, W &wt)
{
	if (AddUniEdge(v1, v2, wt) && AddUniEdge(v2, v1, wt)) return 1;
	else return 0;
}

//**************************************************************
//	Function name:	DeleteBiDirEdge()
//	Purpose:		deleting 2 directions between 2 nodes
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
int Graph<V, W> ::DeleteBiDirEdge(V &v1, V &v2)
{
	DeleteUniEdge(v1, v2);
	DeleteUniEdge(v2, v1);
	return 1;
}

//**************************************************************
//	Function name:	SimplePrintGraph()
//	Purpose:		printing vertex from file
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
void Graph<V, W> ::SimplePrintGraph()
{
	int index = 0;
	for (; index<sizeof(G) / sizeof(vertex<V, W>); index++) {
		vertex<V, W> verx = G[index];
		V veName = verx.name;
		//cout << veName << endl;
		list< edgeRep<V, W> > egList = verx.edgelist;
		list< edgeRep<V, W> >::iterator i;
		for (i = egList.begin(); i != egList.end(); i++) {
			edgeRep<V, W> edg = *i;
			V endName = edg.name;
			W endWeight = edg.weight;
			cout << "<" << veName << "," << endName << "," << to_string(endWeight) << ">" << endl;
		}
	}
}

//**************************************************************
//	Function name:	ShortestDistance()
//	Purpose:		finding shortest distance between vertexs
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
double Graph<V, W> ::ShortestDistance(V &v1, V &v2)
{
	vertex<V, W> w;
	bool s[MAX]; // to record if the node has been in S set;
	int dist[MAX]; // to record distance from ith node to source node;
	int prev[MAX]; // to record the previous node of ith node in shorted path;
	int min;
	int k;

	for (int m = 0; m < MAX; m++) {
		s[m] = 0;
		dist[m] = MAX_I;
		prev[m] = -1;
	}


	int indexOfStart = isVertex(v1);
	int indexOfDes = isVertex(v2);
	dist[indexOfStart] = 0;
	s[indexOfStart] = 1;

	w = G[indexOfStart];
	list< edgeRep<V, W> > egList = w.edgelist;
	list< edgeRep<V, W> >::iterator i;
	for (i = egList.begin(); i != egList.end(); i++) {
		edgeRep<V, W> edg = *i;
		V endName = edg.name;
		W endWeight = edg.weight;
		int indexOfEnd = isVertex(endName);
		dist[indexOfEnd] = endWeight;
		prev[indexOfEnd] = indexOfStart;
	}

	for (int p = 0; p < MAX; p++) {
		if (p == indexOfStart) continue;
		min = MAX_I;
		for (int n = 0; n < MAX; n++) {
			if (!s[n] && dist[n] < min) {
				k = n;
				min = dist[n];
			}
		}
		s[k] = 1;
		w = G[k];
		list< edgeRep<V, W> > egList = w.edgelist;
		list< edgeRep<V, W> >::iterator i;
		for (i = egList.begin(); i != egList.end(); i++) {
			edgeRep<V, W> edg = *i;
			V endName = edg.name;
			W endWeight = edg.weight;
			int indexOfEnd = isVertex(endName);
			if (!s[indexOfEnd] && (min + endWeight) < dist[indexOfEnd]) {
				dist[indexOfEnd] = min + endWeight;
				prev[indexOfEnd] = k;
			}
		}
	}

	cout << "Reversed Path: ";
	cout << "END <- " << v2 << " <- ";

	int qian = prev[indexOfDes];
	while (qian != -1) {
		cout << G[qian].name << " <- ";
		qian = prev[qian];
	}
	cout << "BEGIN" << endl;

	cout << "From " << v1 << " To " << v2 << ":";
	return dist[indexOfDes];
}

//**************************************************************
//	Function name:	GetGraph
//	Purpose:		getting vertex from txt file
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
void Graph<V, W> ::GetGraph()
{
	ifstream infile;
	string filename;
	cout << "Please input the graph file name(absolute path):";
	cin >> filename;
	infile.open(filename);

	vector< vector<string> > martirx;
	vector<string> results;
	string word;
	string delim(" ");
	string textline;
	if (infile.good())
	{
		while (!infile.fail())
		{
			getline(infile, textline);
			string str = textline;
			string::size_type start = 0, index;
			string substr;

			index = str.find_first_of(delim, start);
			while (index != string::npos)
			{
				substr = str.substr(start, index - start);
				results.push_back(substr);
				start = str.find_first_not_of(delim, index);
				if (start == string::npos) return;

				index = str.find_first_of(delim, start);
			}
			martirx.push_back(results);
			results.clear();
		}
	}
	infile.close();

	vector<vector<string>>::iterator iter1;
	vector<string>::iterator iter2;
	for (iter1 = martirx.begin(); iter1 != martirx.end(); iter1++) {
		int count = 0;
		string startVertx;
		string endVertx;
		int weight;
		for (iter2 = (*iter1).begin(); iter2 != (*iter1).end(); iter2++) {
			if (count == 0) {
				startVertx = *iter2;
				AddVertex(startVertx);
			}
			else {
				if (count % 2 == 1) {
					endVertx = *iter2;
				}
				else {
					weight = stoi(*iter2);
					AddUniEdge(startVertx, endVertx, weight);
				}
			}
			count++;
		}
		count = 0;
	}
	//cout << "GETGRAPH DONE" << endl;
}


//**************************************************************
//	Function name:	BFTraversal()
//	Purpose:		printing BFT vertex
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
void Graph<V, W> ::BFTraversal(V &v)
{
	vertex<V, W> w;
	int index = isVertex(v);
	w = G[index];
	
	std::queue<int> q;

	w.visited = 1;
	G[index] = w;
	cout << w.name << " -> ";
	q.push(index);

	while (!q.empty()) {
		int inx = q.front();
		q.pop();
		w = G[inx];

		list< edgeRep<V, W> > egList = w.edgelist;
		list< edgeRep<V, W> >::iterator i;
		for (i = egList.begin(); i != egList.end(); i++) {
			edgeRep<V, W> edg = *i;
			string vName = edg.name;
			int seq = isVertex(vName);
			w = G[seq];

			if (w.name == "empty") continue;
			if (w.visited == 0) {
				w.visited = 1;
				G[seq] = w;
				q.push(seq);
				cout << w.name << " -> ";
			}
		}
	}
	
}

//**************************************************************
//	Function name:	DFTraversal()
//	Purpose:		printing DFT vertex
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
void Graph<V, W> ::DFTraversal(V &v)
{
	vertex<V, W> w;
	int index = isVertex(v);
	w = G[index];

	if (w.name == "empty") return;
	if (w.visited == 0) {
		cout << w.name << " -> ";
		w.visited = 1;
		G[index] = w;
	}
	else return;

	list< edgeRep<V, W> > egList = w.edgelist;
	list< edgeRep<V, W> >::iterator i;
	for (i = egList.begin(); i != egList.end(); i++) {
		edgeRep<V, W> edg = *i;
		string vName = edg.name;
		DFTraversal(vName);
	}
}

#endif
