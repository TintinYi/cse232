#ifndef L7_H_
#define L7_H_

template<typename T>
class A {
	protected:
		T  number;
};

template <typename T>
class B : public A<T> {

	public: void set(T n) {
		number = n;
	}

	public: void f()
	{
		cout << "From derived class B, number is: " << number << endl; 
	}
};

template <typename T>
class C : public B<T> {
	
	public: void f()
	{
		cout << "From derived class C, number is: " << number << endl; 
	}
};

#endif