#ifndef PJ2_1_T
#define PJ2_1_T

#include <fstream>
#include <string>
#include <iostream>
#include <vector>

using namespace std;

template <class V, class W>
Graph<V,W>::Graph()
{
	vertex<V,W> vex;
	vex.name = "empty";
	vex.visited = 0;
	list< edgeRep<V,W> > egList;
	vex.edgelist = egList;
	for (int i=0; i<32; i++) G[i] = vex;
	cout << "Graph created!" << endl;

}

template <class V, class W>
Graph<V,W>::~Graph()
{
	cout << "Graph deleted!" << endl;
}


template <class V, class W>
int Graph<V,W>::isVertex(V &v)
{
	int index = 0;
	for(;index < sizeof(G)/sizeof(vertex<V,W>); index++) {
		vertex<V,W> vert = G[index];
		if (vert.name == v) return index;
	}
	return -1;
}

template <class V, class W>
int Graph<V,W> :: isUniEdge(V &v1, V &v2)
{
	int index = 0;
	vertex<V,W> vert = G[index];

	while (vert != nullptr) {
		if (vert.name == v1.name) {

			int indexOfEdge = 0;
			edgeRep edge = vert.edgelist[indexOfEdge];

			while (edge != nullptr) {
				if (edge.name == v2.name) return 1;
				else {
					indexOfEdge ++;
					edge = vert.edgelist[indexOfEdge];
				}
			}
		} else {
			index ++;
			vert = G[index];
		}
	}
	return 0;
}

template <class V, class W>
int Graph<V,W> :: isBiDirEdge(V &v1, V &v2)
{
	if (isUniEdge(v1, v2) && isUniEdge(v2, v1)) return 1;
	else return 0;
}



template <class V, class W>
int Graph<V,W> :: AddVertex(V &v)
{
	int index = 0;

	for (; index <sizeof(G)/sizeof(vertex<V,W>); index++) {
		vertex<V,W> vert = G[index];
		if (vert.name == "empty") {
			vertex<V,W> vex;
			vex.name = v;
			vex.visited = 0;
			list< edgeRep<V,W> > edList;
			vex.edgelist = edList;
			G[index] = vex;
			return index;
		}
		else if (vert.name == v) return index;
		else {
			index ++;
			vert = G[index];
		}
	}
	vertex<V,W> vex;
	vex.name = v;
	vex.visited = 0;
	list< edgeRep<V,W> > edList;
	vex.edgelist = edList;
	G[index] = vex;
	return index;
}


template <class V, class W>
int Graph<V,W> :: DeleteVertex(V &v)
{
	auto itrOfGraph = G.begin();
	while (itrOfGraph != G.end()) {
		if (itrOfGraph.name == v.name) itrOfGraph = G.erase(itrOfGraph);
		if (itrOfGraph != G.end()) {
			itrOfGraph ++;
			continue;
		}

		auto itrOfEdge = itrOfGraph.begin();

		while (itrOfEdge != itrOfGraph.end()) {
			if (itrOfEdge.name == v.name) itrOfEdge = itrOfGraph.erase(itrOfEdge);
			if (itrOfEdge != itrOfGraph.end()) itrOfEdge ++;
		}
	}
}


template <class V, class W>
int Graph<V,W> :: AddUniEdge(V &v1, V &v2, W &wt)
{
	int index = 0;
	for (; index <sizeof(G)/sizeof(vertex<V,W>); index++) {
		vertex<V,W> vert = G[index];
		
		if (vert.name == v1) {
			list< edgeRep<V,W> >::iterator i;
			for (i=vert.edgelist.begin(); i!=vert.edgelist.end(); i++) {
				edgeRep<V,W> eg = *i;
				if (eg.name == v2) return 1;
			}
			edgeRep<V,W> egInsert;
			egInsert.name = v2;
			egInsert.weight = wt;
			vert.edgelist.push_back(egInsert);
			cout << vert.name + " ";
			cout << egInsert.name + " ";
			cout << egInsert.weight << endl;
			G[index] = vert;
			return 1;
		}
		else {
			index ++;
			vert = G[index];
		}
	}
	return 0;
}



template <class V, class W>
int Graph<V,W> :: DeleteUniEdge(V &v1, V &v2)
{
	auto itrOfGraph = G.begin();
	while (itrOfGraph != G.end()) {
		if (itrOfGraph.name == v1.name) {
			auto itrOfEdge = itrOfGraph.begin();

			while (itrOfEdge != itrOfGraph.end()) {
				if (itrOfEdge.name == v2.name) itrOfEdge = itrOfGraph.erase(itrOfEdge);
				if (itrOfEdge != itrOfGraph.end()) itrOfEdge ++;
			}
		}
		itrOfGraph = G.erase(itrOfGraph);
		if (itrOfGraph != G.end()) {
			itrOfGraph ++;
			continue;
		}
	}
}



template <class V, class W>
int Graph<V,W> :: AddBiDirEdge(V &v1, V &v2, W &wt)
{
	if (AddUniEdge(v1, v2, wt) && AddUniEdge(v2, v1, wt)) return 1;
	else return 0;
}




template <class V, class W>
int Graph<V,W> :: DeleteBiDirEdge(V &v1, V &v2)
{
	DeleteUniEdge(v1,v2);
	DeleteUniEdge(v2,v1);
	return 1;
}

template <class V, class W>
void Graph<V,W> :: SimplePrintGraph()
{
	cout << "Start printing:" << endl;
	int index=0;
	for (; index<sizeof(G)/sizeof(vertex<V,W>); index++) {
		vertex<V,W> verx = G[index];
		V veName = verx.name;
		if (veName == "empty") continue;
		cout << veName << endl;
		list< edgeRep<V,W> > egList = verx.edgelist;
		list< edgeRep<V,W> >::iterator i;
		for (i=egList.begin(); i!=egList.end(); i++) {
			edgeRep<V,W> edg = *i;
			V endName = edg.name;
			W endWeight = edg.weight;
			cout << "<" << veName << "," << endName << "," << to_string(endWeight) << ">" << endl;
		}
	}
}


template <class V, class W>
double Graph<V,W> :: ShortestDistance(V &v1, V &v2)
{
	

}


template <class V, class W>
void Graph<V,W> :: GetGraph()
{
	ifstream infile;
	infile.open("graph2.txt");

	vector< vector<string> > martirx;
	vector<string> results;  
    string word;  
    string delim(" ");  
    string textline;  
    if(infile.good())  
    {  
        while(!infile.fail())  
        {  
            getline(infile, textline);
			string str = textline;  
			string::size_type start = 0, index;  
			string substr;  
  
			index = str.find_first_of(delim, start); 
			while(index != string::npos)  
			{  
				substr = str.substr(start, index-start);  
				results.push_back(substr);  
				start = str.find_first_not_of(delim, index); 
				if(start == string::npos) return;  
  
				index = str.find_first_of(delim, start);  
			}
			martirx.push_back(results);
			results.clear();
        }  
    }  
    infile.close();  
  
	vector<vector<string>>::iterator iter1;
	vector<string>::iterator iter2;
	for (iter1=martirx.begin(); iter1!=martirx.end(); iter1++) {
		int count = 0;
		string startVertx;
		string endVertx;
		int weight;
		for (iter2=(*iter1).begin(); iter2!=(*iter1).end(); iter2++) {
			if (count == 0) {
				startVertx = *iter2;
				AddVertex(startVertx);
			} else {
				if (count%2==1) {
					endVertx = *iter2;
				} else {
					weight = stoi(*iter2);
					AddUniEdge(startVertx, endVertx, weight);
				}
			}
			count ++;
		}
		count = 0;
	}
	cout << "GETGRAPH DONE" << endl;
}



template <class V, class W>
void Graph<V,W> :: BFTraversal(V &v)
{
	std::stack<GtNode<BaseData>*> nodes2visitStack;
    std::queue<GtNode<BaseData>*> nodes2visit;

    GtNode<BaseData> *item = GenTree<BaseData>::root;

	if (item) {
        nodes2visit.push( item );
		while (!(nodes2visit.empty() && nodes2visitStack.empty())) {
			if(nodes2visitStack.empty()) {
				item = nodes2visit.front();
				nodes2visit.pop();
			} else {
				item = nodes2visitStack.top();
				nodes2visitStack.pop();
			}
            processnode((item->info));
            if (item -> firstChild) nodes2visit.push(item -> firstChild);
            if (item -> sibling) nodes2visitStack.push(item -> sibling);
		}
	}
}


template <class V, class W>
void Graph<V,W> :: DFTraversal(V &v)
{


}

#endif
