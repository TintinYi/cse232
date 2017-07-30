

#ifndef AVLTREE_H
#define AVLTREE_H

#include <cstdio>

#include "BinSearchTree.h"
#include "AvlNode.h"


template < typename BaseData >
class AvlTree : public BinTree<BaseData>
  {
  
  public:
    AvlTree ( bool (*precedes)(const BaseData& x, const BaseData& y)  );
    AvlTree (const AvlTree<BaseData> &initAvlTree);
    virtual bool add(BaseData item);

  protected:
    // Comparison function for items in tree
    bool (*precedes)(const BaseData& x, const BaseData& y);

  private:
    bool addAux( GtNode<BaseData> *&rt, const BaseData item);
    void leftOfLeft( GtNode<BaseData> * &pivot );
    void rightOfLeft( GtNode<BaseData>* &pivot );
    void leftOfRight( GtNode<BaseData> *& pivot );
    void rightOfRight( GtNode<BaseData> *& pivot );


  };



#include "AvlTree.t"


#endif
