

#ifndef AVL_NODE_H
#define AVL_NODE_H


#ifndef leftChild
#define leftChild  firstChild
#endif

#ifndef rightChild
#define rightChild  sibling
#endif



#include "GtNode.h"

template <class BaseData>
class avlNode : public GtNode<BaseData>
  {
  public:
    avlNode();
    avlNode<BaseData> &operator = ( const avlNode<BaseData> & initAvlNode );
    avlNode (const avlNode<BaseData> &initNode);
    short bf; //balance factor
  };


template <class BaseData>
avlNode<BaseData>::avlNode() : GtNode<BaseData>()
{
  bf = 0;
}


template <class BaseData>
avlNode<BaseData>& avlNode<BaseData>::
operator = (  const avlNode<BaseData> & initNode )
{
  GtNode<BaseData>::operator = ( initNode )
  (*this).bf = initNode.bf;

  return *this;
}




template <class BaseData>
avlNode<BaseData>::avlNode(  const avlNode<BaseData> & initNode )
                                     : GtNode<BaseData>(initNode)
{
  (*this).bf = initNode.bf;
}









#endif
