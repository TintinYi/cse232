#include <fstream>
#include <string>
#include <iostream>


template <class V, class W>
Graph<V,W>::Graph()
{
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
	vertex<V,W> vert = G[index];

	while (vert != nullptr)
	{
		if (vert.name == v.name) return 1;
		else {
			index ++;
			vert = G[index];
		}
	}
	return 0;
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
	vertex<V,W> vert = G[index];

	while (vert != nullptr) {
		if (vert.name == v.name) return index;
		else {
			index ++;
			vert = G[index];
		}
	}
	G[index] = v;
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
	vertex<V,W> vert = G[index];

	while (vert != nullptr) {
		if (vert.name == v1.name) {

			int indexOfEdge = 0;
			edgeRep edge = vert.edgelist[indexOfEdge];

			while (edge != nullptr) {
				if (edge.name == v2.name) return indexOfEdge
					;
				else {
					indexOfEdge ++;
					edge = vert.edgelist[indexOfEdge];
				}
			}
			edgeRep<V,W> e = edgeRep<v2.name, wt>;
			vert.edgelist[indexOfEdge] = e;
		} else {
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
	auto itrOfGraph = G.begin();
	while (itrOfGraph != G.end()) {
		auto itrOfEdge = itrOfGraph.begin();

		while (itrOfEdge != itrOfGraph.end()) {
			cout << "<" + itrOfGraph.name + "," + itrOfEdge.name + "," + itrOfEdge.weight + ">" << endl;
			if (itrOfEdge != itrOfGraph.end()) itrOfEdge ++;
		}
		if (itrOfGraph != G.end()) {
			itrOfGraph ++;
			continue;
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
	ifstream inFile;
	inFile.open("");

	array arr[row][colum];
	int row =0, colum =0;
	string str1;
	char ch1;

	while(!inFile.eof())
	{
		if(ch1 == '#')
			row++; colum = 0;
		else
		{
			while (ch1 != ' ')
			{
		str1 += ch1;
	
			} 
	
		arr[row][colum] = str1; colum ++;
		str1.clear();
		}

	}
	
	for(int i = 0; i <row; i++)
	{
		string vertexName;
		string edgeName;
		int weight;
		for(int j =0; j <colum; j++)
		{
			if(j==0) {
				vertexName = arr[i][j];
				AddVertex(vertexName);
			} else if (j%2 == 1) {
				edgeName = arr[i][j];
			} else if (j%2 == 0) {
				weight = arr[i][j];
				AddUniEdge(vertexName, edgeName, weight);
				edgeName.clear();
				weight = 0;
			}
		}
		vertexName.clear();
	}
	return null;
}



template <class V, class W>
void Graph<V,W> :: BFTraversal(V &v)
{
	/*std::stack<  GtNode<BaseData>* > nodes2visitStack;
    std::queue<  GtNode<BaseData>* > nodes2visit;

    GtNode<BaseData>  *item = GenTree<BaseData>::root;


    if ( item )
      {
        nodes2visit.push( item );

		while ( !(nodes2visit.empty() && nodes2visitStack.empty()) )
          {		  

           if(nodes2visitStack.empty())
		   {
			item  =  nodes2visit.front();
            nodes2visit.pop();
		   }
		   else
		   {
			   item  =  nodes2visitStack.top();
            nodes2visitStack.pop();
		   
		   }
            processnode( (item->info) );

            if (item -> firstChild )
              nodes2visit.push( item -> firstChild );
            if (item -> sibling )
              nodes2visitStack.push( item -> sibling );
          }
      }*/

}


template <class V, class W>
void Graph<V,W> :: DFTraversal(V &v)
{


}

