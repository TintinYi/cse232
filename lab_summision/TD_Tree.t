/**************************************************************************************************
*
*   File name :			TD_Tree.t
*
*   This program		modify the given files for breadthFirstTraversal
*
*
*   Programmer:  		Sai Sao Kham
*
*   Date Written:		01/25/2015
*
*   Date Last Revised:	01/25/2015
*
***************************************************************************************************/


#ifndef TDTREE_T
#define TDTREE_T

#include <cstdio>



template <class BaseData>
TDTree<BaseData>::TDTree(int (*precedes)(const BaseData& x, const BaseData& y))
  : GenTree<BaseData> ()
{
  compare = precedes;
}

template <class BaseData>
TDTree<BaseData>::TDTree(const TDTree<BaseData> & initTopDownTree)
  : GenTree<BaseData> (initTopDownTree)
{
  compare = initTopDownTree.compare;
}


template < class BaseData>
bool TDTree<BaseData>::add(BaseData parent, BaseData item, int childnum)
{
  if ( GenTree<BaseData>::root == 0 )
    {
      GenTree<BaseData>::root = new GtNode<BaseData>;
      GenTree<BaseData>::root->info = item;
      GenTree<BaseData>::root->firstChild = NULL;
      GenTree<BaseData>::root->sibling = NULL;
      return(true);
    }
  else
    return(add_aux( GenTree<BaseData>::root, parent, item, childnum) );
}



template < class BaseData>
bool TDTree<BaseData>::add_aux(GtNode<BaseData> * rt, BaseData parent,
                               BaseData item, int childnum)
{
  GtNode<BaseData> *temp;
  GtNode<BaseData> *prev;
  int c ;

  if ( rt !=  0 )
    if (compare(parent,rt->info) == 0)
      {
        temp = new GtNode<BaseData>;
        temp->info = item;
        temp->firstChild = 0;
        if (childnum == 1 || rt->firstChild == 0)
          {
            temp->sibling = rt->firstChild;
            rt->firstChild = temp;
          }
        else
          {
            for ( c = 2, prev = rt -> firstChild; ( c<childnum && prev != 0 );
                  ++c, prev = prev -> sibling) ;
            temp -> sibling = prev -> sibling;
            prev -> sibling = temp;
          }
        return(true);
      }
    else if (!add_aux(rt->firstChild,parent,item,childnum))
      return(add_aux(rt->sibling,parent,item,childnum));
    else
      return(true);
  else
    return(false);
}



template <class BaseData>
void TDTree<BaseData>::breadthFirstTraversal( void (*processnode)(BaseData &value) )
{
	std::stack<  GtNode<BaseData>* > nodes2visitStack;
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
      }

  


}



#endif


