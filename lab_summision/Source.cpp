#include <iostream>
#include <string>
using namespace std;

// THIS IS TO DEMONSTRATE POINTER FUNCTIONS



class Stan{
public:
 
 void print_message(int test, string (*ptrFunct)(int))
 {
 cout<< (*ptrFunct)(test);
 }
 
};


string message_dumb(int j)
{
 string message ="";
 for(int i=0;i<j;i++)
 message = message + "stan is dumb \n";
 return message;
}


string message_smart(int k)
{
 string message ="";
 for(int i=0;i<k;i++)
 message = message + "stan is smart \n";
 return message;
}



int main()
{
 Stan ManyStans;
 int test;
 cout << "enter a number: ";
 cin >> test;
 
 //making function pointers
 //return_type (*ptr_func_variable_name) (parameter_type_, par2,...) = func_you're_pointing_to
 string (*mesageSmart) (int) = message_smart;
 string (*messageDumb) (int) = message_dumb;
 
 ManyStans.print_message(test,message_smart);
 cout << "\n\n\n";
 ManyStans.print_message(test,message_dumb);
 
 return 0;
 
}

//SAMPLE OUTPUT
//enter a number: 2
//stan is smart
//stan is smart
//
//
//
//stan is dumb
//stan is dumb
//Program ended with exit code: 0