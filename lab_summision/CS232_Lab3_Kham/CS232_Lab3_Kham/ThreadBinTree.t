//****************************************************************************************
//
//	File Name:			ThreadBinTree.t	
//	
//	Programmer:			Sai Sao Kham	
//
//	Purpose:			adding more functions on given codes
//						
//
//	Date created:			02_05_2015
//
//	Date last modified:		02_07_2015
//
//****************************************************************************************

#ifndef THREADBINTREE_T
#define THREADBINTREE_T



#include <cstdio>

#ifndef leftChild
#define leftChild  firstChild
#endif

#ifndef rightChild
#define rightChild  sibling
#endif



template <class BaseData>
BinThreadTree<BaseData>::
BinThreadTree (  bool (*precedes)(const BaseData& x, const BaseData& y)    )   : BinSearchTree<BaseData> (  BinSearchTree<BaseData>::precedes )
{

  if (   GenTree<BaseData>::root == 0 )
    delete GenTree<BaseData>::root;

  BinThreadTree<BaseData>::root = new threadBinNode<BaseData>;		//	root ptr is now a dynamic ptr at run time when an object is created 
  BinThreadTree<BaseData>::root -> leftChild =  BinThreadTree<BaseData>::root;	//	left child is null
  BinThreadTree<BaseData>::root -> rightChild =  BinThreadTree<BaseData>::root;	//	right child is null
  BinThreadTree<BaseData>::root -> leftThread =  true;	// left thread is true 
  BinThreadTree<BaseData>::root -> rightThread =  false;	// right thread is false 

}



/*
template <class BaseData>
BinSearchTree<BaseData>::BinSearchTree (const BinSearchTree<BaseData> &initBinSTree)
{
  precedes=initBinSTree.precedes;
}
*/


template <class BaseData>
bool BinThreadTree<BaseData>::inOrderAdd( BaseData item)
{
  threadBinNode<BaseData> *q, *p, *parentq;	//	3 node pointers are defined
  bool left, done;		// 2 bool variables are defined one called left, one called done return T or F
  p = new threadBinNode<BaseData>;	//	p is delcared to be dynamically allocated at run time because we do not know the size 
  p -> info = item;					// p's pointer to info is set equal to item
  // Prepare for the while test by following the left child pointer
  // from the dummy header

  parentq =  BinThreadTree<BaseData>::root;	//	Set parent q ptr = to the root which is an int 
  q =   static_cast< threadBinNode<BaseData>*  >	//	type change from thread binNode basedata to binThreadTree basedata 
        ( BinThreadTree<BaseData>::root ->  leftChild ) ;	//q points to the left child 

  left = true;						//	the boolean value of left is set equal to true 
  done = parentq -> leftThread;		// the boolean value of done is set equal to the pointer parentq which points to left thread
  

  // done is true if it points to the left thread 
  while ( !done )	// while done does not point to the left thread 

    // Now allow q and its parent to travel down an appropriate branch until
    // an insertion spot is found
    //   if (precedes( item, q -> info) )
    if ( item <= q -> info )
      {
        parentq = static_cast< threadBinNode<BaseData>*  >(q);
        q =  static_cast< threadBinNode<BaseData>*  >
             (q -> leftChild )  ;
        left = true;
        done = parentq -> leftThread;
      }
    else
      {

        parentq = static_cast< threadBinNode<BaseData>*  >(q);
        q =  static_cast< threadBinNode<BaseData>*  >
             ( q -> rightChild ) ;
        left = false;
        done = parentq -> rightThread;
      }


  // Now insert p as the left or right child of parentq
  p -> leftThread = true;
  p -> rightThread = true;
  if (left)
    {
      p -> leftChild = static_cast< threadBinNode<BaseData>*  >( parentq -> leftChild);
      p -> rightChild =static_cast< threadBinNode<BaseData>*  >(parentq);
      parentq -> leftChild = static_cast< threadBinNode<BaseData>*  >(p);
      parentq -> leftThread = false;
    }
  else
    {
      p -> rightChild =
        static_cast< threadBinNode<BaseData>*  >(parentq -> rightChild);
      p -> leftChild =
        static_cast< threadBinNode<BaseData>*  >(parentq);

      parentq -> rightChild = static_cast< threadBinNode<BaseData>*  >(p);
      parentq -> rightThread = false;
    }


  return true ;
}



template <class BaseData>
void BinThreadTree<BaseData>::inorder(void (*processNode)(BaseData &item))
{

  threadBinNode<BaseData>  *p;					// a threadbinNode ptr p 
  p =   BinThreadTree<BaseData>::root;			// p is set equal to the root 
  do
    {
      if (p->rightThread)	
        p = static_cast< threadBinNode<BaseData>*  >(p->rightChild);
      else
        {
          p = static_cast< threadBinNode<BaseData>*  >(p->rightChild);
          while (!p->leftThread)
            p =  static_cast< threadBinNode<BaseData>*  >(p->leftChild);
        }
      if (p !=  BinThreadTree<BaseData>::root )
        processNode(p->info);
    }
  while (p != root);
}


// ALL RC PTRS THAT ARE NULL POINT TO THE SUCCESSOR ||  ALL LC PTRS THAT ARE NULL POINT TO THE PREDECESSOR 

template <class BaseData>
bool BinThreadTree<BaseData>::preOrderAdd( BaseData item)
{
	 threadBinNode<BaseData> *q, *p, *parentq;	//	3 node pointers are defined
  bool left, done;		// 2 bool variables are defined one called left, one called done return T or F
  p = new threadBinNode<BaseData>;	//	p is delcared to be dynamically allocated at run time because we do not know the size 
  p -> info = item;					// p's pointer to info is set equal to item
  // Prepare for the while test by following the left child pointer
  // from the dummy header

  parentq =  BinThreadTree<BaseData>::root;	//	Set parent q ptr = to the root which is an int 
  q =   static_cast< threadBinNode<BaseData>*  >	//	type change from thread binNode basedata to binThreadTree basedata 
        ( BinThreadTree<BaseData>::root ->  leftChild ) ;	//q points to the left child 

  left = true;						//	the boolean value of left is set equal to true 
  done = parentq -> leftThread;		// the boolean value of done is set equal to the pointer parentq which points to left thread
  

  // done is true if it points to the left thread 
  while ( !done )	// while done does not point to the left thread 

    // Now allow q and its parent to travel down an appropriate branch until
    // an insertion spot is found
    //   if (precedes( item, q -> info) )
    if ( item <= q -> info )
      {
        parentq = static_cast< threadBinNode<BaseData>*  >(q);
        q =  static_cast< threadBinNode<BaseData>*  >
             (q -> leftChild )  ;
        left = true;
        done = parentq -> leftThread;
      }
    else
      {

        parentq = static_cast< threadBinNode<BaseData>*  >(q);
        q =  static_cast< threadBinNode<BaseData>*  >
             ( q -> rightChild ) ;
        left = false;
        done = parentq -> rightThread;
      }


  // Now insert p as the left or right child of parentq
  p -> leftThread = true;
  p -> rightThread = true;
  if (left)
    {
      p -> leftChild = static_cast< threadBinNode<BaseData>*  >( parentq -> leftChild);
      p -> rightChild =static_cast< threadBinNode<BaseData>*  >(parentq);
      parentq -> leftChild = static_cast< threadBinNode<BaseData>*  >(p);
      parentq -> leftThread = false;
    }
  else
    {
      p -> rightChild =
        static_cast< threadBinNode<BaseData>*  >(parentq -> rightChild);
      p -> leftChild =
        static_cast< threadBinNode<BaseData>*  >(parentq);

      parentq -> rightChild = static_cast< threadBinNode<BaseData>*  >(p);
      parentq -> rightThread = false;
    }


  return true ;

}



template <class BaseData>
void BinThreadTree<BaseData>::preorder(void (*processNode)(BaseData &item))
{
	 threadBinNode<BaseData>  *p;					// a threadbinNode ptr p 
  p =   BinThreadTree<BaseData>::root;			// p is set equal to the root 
  do
    {
       if(p->leftThread && p->rightThread)
	   {
			 p = static_cast< threadBinNode<BaseData>*  >(p->rightChild);
			 p = static_cast< threadBinNode<BaseData>*  >(p->rightChild);
			 if (p !=  BinThreadTree<BaseData>::root )
			 processNode(p->info);
	   }
      else
        {
			 if (p->leftThread)	
			 {
			   p = static_cast< threadBinNode<BaseData>*  >(p->rightChild);
		       // if (p !=  BinThreadTree<BaseData>::root )
               processNode(p->info);
			 }
		    else
			{
			  p = static_cast< threadBinNode<BaseData>*  >(p->leftChild);
			  processNode(p->info);
		    }
		}
		  //while(p->leftThread)
            // p =  static_cast< threadBinNode<BaseData>*  >(p->rightChild);
	 
     
    }
  while (p != root);
  	
  
}


#endif

