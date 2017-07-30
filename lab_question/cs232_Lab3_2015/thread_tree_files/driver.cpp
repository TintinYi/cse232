


#include <iostream>
using std::cout;
using std::cin;
using std::endl;



#include "TD_Tree.h"
//#include "BinTree.h"
#include "BinSearchTree.h"

#include "ThreadBinTree.h"

int preceed (const char& c1, const char& c2)
{
  return  c1 - c2;
}


bool preceed2 (const int &x, const int &y)
{
  return x <= y;
}


void dump(char & value)
{
  cout << value;
}

void dump2( int & value)
{
  cout << value << "  ";
}


int main()
{

  cout << endl;

  /*

   BinThreadTree<int> t5(preceed2);

    t5.preOrderAdd( 555 );
    t5.preOrderAdd( 111 );
    t5.preOrderAdd( 333 );
   t5.preOrderAdd( 99 );
   t5.preOrderAdd( 866 );
   t5.preOrderAdd( 666 );
   t5.preOrderAdd( 777 );

    t5.preorder( dump2);


  */








  /*

    TDTree<char>  t1( preceed);
    t1.add( 'H', 'H', 1 );
    t1.add( 'H', 'i', 1 );
    t1.add( 'i', ' ',  1);
    t1.add( 'H', 't', 2 );
    t1.add( 't', 'h', 1 );
    t1.add( 't', 'r', 2 );
    t1.add( 't', 'e', 3 );
    t1.add( 'h', 'E',  1);
    cout << " t1 printing breadth first traversal \n";
    t1.breadthFirstTraversal( dump);
    cout << endl << endl;


    cout << " t1 printing depth first traversal \n";
    t1.depthFirstTraversal( dump);
    cout << endl << endl;

  */







  cout<<endl;

  return (0);

}



