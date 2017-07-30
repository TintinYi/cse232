


#include <iostream>
using std::cout;
using std::cin;
using std::endl;



#include "AvlTree.h"

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
  
   cout << " \n\nAVL Tree "  << endl;

    AvlTree<int> t7( preceed2 );
    t7.add( 60 );
    t7.add( 80 );
    t7.add( 30 );
    t7.add( 90 );
    t7.add( 70 );
    t7.add( 100 );
    t7.add( 40 );
    t7.add( 20 );
    t7.add( 50 );
    t7.add( 10 );




    cout << " t7 printing depth first traversal \n ";
    t7.depthFirstTraversal( dump2);

    t7.breadthFirstTraversal( dump2);


    cout<<endl;

  









  cout<<endl;

  return (0);

}



