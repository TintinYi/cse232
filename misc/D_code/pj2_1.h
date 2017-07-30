#ifndef PJ2_1_H_
#define PJ2_1_H_

#include <list>
#include <queue>
#include <climits>
#include <vector>
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

#define MAX 32
#define MAX_I 65535


template <class V, class W>
struct edgeRep
{ 
  V name;
  W weight;
};

template <class V, class W>
struct vertex
{
	typedef struct edgeRep<V,W> edge;
	V name;
	int visited;
	list<edge> edgelist;
};

template <class V, class W>
class Graph
{ 
  protected:
	  vertex<V,W> G[MAX];

  public:
    Graph();   // Constructor
    // . . . other constructors
    ~Graph();  // Destructor
    //Predicates:
    int isVertex(V &v);  // Tests whether v is a vertex in the graph
    int isUniEdge(V &v1, V &v2); // Tests whether edge <v1,v2> in graph
    int isBiDirEdge(V &v1, V &v2);// Tests whether edge (v1,v2) in graph
    	  // The following functions return -1 for failure, non-neg for success
    int AddVertex(V &v);
	  // Adds vertex with name v to the graph, if v is not already in 
	  // graph, and returns the index where the vertex is stored.
    int DeleteVertex(V &v);
	  // Deletes vertex with name v from the graph, if v is in the graph.
	  // If there are any edges incident on the vertex, these edges
 	  // are deleted also.
    int AddUniEdge(V &v1, V &v2, W &wt);
	  // Adds the directed edge <v1,v2,wt> to the graph; adds the vertices
  // to the graph if the vertices are not already part of the graph    
    int /*void*/  DeleteUniEdge(V &v1, V &v2); // WHAT THE EXACTLY RETURN TYPE
	  // Deletes the directed edge <v1,v2> (any weight) from the graph, if 
	  // it is in the graph. The vertices are not deleted from the graph,
	  // only the edge.
    int AddBiDirEdge(V &v1, V &v2, W &wt);
	  // Adds the bi-directional edge (v1,v2,wt) to the graph; adds the
         // vertices to the graph if the vertices are not already part of 
         // the graph
    int DeleteBiDirEdge(V &v1, V &v2);
	  // Deletes the bi-directional edge (v1,v2) (any weight) from the 
	  // graph, if it is in the graph. The vertices are not deleted from 
	  // the graph, only the edge.
    void SimplePrintGraph();
	  // Prints the list of vertices in the graph, and for each vertex,
	  // prints the list of edges in proper parenthesized notation, namely
	  // (v1,v2,wt) or <v1,v2,wt>.  NOTE: This is not a traversal.
    double ShortestDistance(V &v1, V &v2); //WHY MISSING COMMA
	  //returns the shortest distance from vertex 1 to vertex 2
	  // must implement Dijkstra pseudocode from class
    void GetGraph();
        //Retrieves a graph from a special disk file and sets up the adjacency
        //list for the graph.  I am supplying 3 such files.
    void BFTraversal(V &v);
	  // Performs Breadth First Traversal with trace information printed 
    void DFTraversal(V &v);
          //Performs a recursive Depth First Traversal of the graph starting at 
	   //specified vertex (parameter); prints trace information.
    
};

template <class V, class W>
Graph<V, W>::Graph()//constructor
{
	vertex<V, W> vex;
	vex.name = "empty";
	vex.visited = 0; // initial vertex without visited
	list< edgeRep<V, W> > egList;
	vex.edgelist = egList;
	for (int i = 0; i<MAX; i++) G[i] = vex;
	cout << "Graph created!" << endl;

}

template <class V, class W>
Graph<V, W>::~Graph()
{
	cout << "Graph deleted!" << endl;
}


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

template <class V, class W>
int Graph<V, W> ::isBiDirEdge(V &v1, V &v2)
{
	if (isUniEdge(v1, v2) && isUniEdge(v2, v1)) return 1;
	else return 0;
}



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



template <class V, class W>
int Graph<V, W> ::AddBiDirEdge(V &v1, V &v2, W &wt)
{
	if (AddUniEdge(v1, v2, wt) && AddUniEdge(v2, v1, wt)) return 1;
	else return 0;
}




template <class V, class W>
int Graph<V, W> ::DeleteBiDirEdge(V &v1, V &v2)
{
	DeleteUniEdge(v1, v2);
	DeleteUniEdge(v2, v1);
	return 1;
}

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

	cout << "Reversed Path:";
	cout << "END<-" << v2 << "<-";

	int qian = prev[indexOfDes];
	while (qian != -1) {
		cout << G[qian].name << "<-";
		qian = prev[qian];
	}
	cout << "BEGIN" << endl;

	cout << "From " << v1 << " To " << v2 << ":";
	return dist[indexOfDes];
}


template <class V, class W>
void Graph<V, W> ::GetGraph()
{
	ifstream infile;
	infile.open("graph2.txt");

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



template <class V, class W>
void Graph<V, W> ::BFTraversal(V &v)
{
	vertex<V, W> w;
	int index = isVertex(v);
	w = G[index];
	
	std::queue<int> q;

	w.visited = 1;
	G[index] = w;
	cout << w.name << "->";
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
				cout << w.name << "->";
			}
		}
	}
	
}


template <class V, class W>
void Graph<V, W> ::DFTraversal(V &v)
{
	vertex<V, W> w;
	int index = isVertex(v);
	w = G[index];

	if (w.name == "empty") return;
	if (w.visited == 0) {
		cout << w.name << "->";
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


//#include "pj2_1.t"
#endif

