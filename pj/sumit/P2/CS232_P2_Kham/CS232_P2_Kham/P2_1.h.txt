//*************************************************************
//
//	File Name:				P2_1.h	
//
//	Programmer:				Sai Sao Kham	
//
//	Purpose:				Function header
//						
//
//	Date created:			03_19_2015	
//
//	Date last modified:		03_23_2015
//
//**************************************************************
#ifndef PJ2_1_H_
#define PJ2_1_H_

#include <list>
#include <queue>
//#include <climits>
#include <vector>
#include <fstream>
#include <string>
#include <iostream>

using namespace std;

#define MAX 32
#define MAX_I 65535 // max size for int

//**************************************************************
//	Function name:	edgeRep
//	Purpose:		
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
struct edgeRep
{ 
  V name;
  W weight;
};

//**************************************************************
//	Function name:	vertex
//	Purpose:		list, name, 
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
template <class V, class W>
struct vertex
{
	typedef struct edgeRep<V,W> edge;
	V name;
	int visited;
	list<edge> edgelist;
};

//**************************************************************
//	Function name:	Graph
//	Purpose:		function headers
//	Input:			None
//	Output:			None
//	Return type:	void
//**************************************************************
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
#include "P2_1.t"
#endif

