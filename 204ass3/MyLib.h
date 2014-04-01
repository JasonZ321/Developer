//
//  MyLib.h
//  204ass3
//
//  Created by Jason Zhou on 13-10-10.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#ifndef _04ass3_MyLib_h
#define _04ass3_MyLib_h
//#include <exception>

#include <sstream>
#include <iostream>
using namespace std;
namespace MyLib {
   
    class MyException : public std::runtime_error
    {
    private:
        int m,n;
    public:
        MyException();
        MyException(int,int);
        //inline  getValue()const{return value;};
        //inline int getSize()const{return size;};
    };
    MyException::MyException(int m,int n):m(m),n(n),runtime_error("")
    {
        stringstream ss;
        ss << n;
        
        string err_msg = "Out of the bound for the Bucket. The bound is [0," + ss.str();
        
        ss.str("");
        ss << m;
        
        err_msg += "). The value passed is " + ss.str() + ".";
        runtime_error::runtime_error(static_cast<const string&>(err_msg));
    }

   
    template <class T>
    void swap(T &a,T &b)
    {
        T temp = a;
        a = b;
        b = temp;
    }
    template <class T>
    void sort(T *array,int size)
    {
        bool swapped;
        do
        {
            swapped = false;
            for(int i = 0;i<size-1;i++)
            {
                if(*(array+i) > *(array+i+1))
                {
                    swap(*(array+i),*(array+i+1));
                    swapped = true;
                }
            }
        } while (swapped);
    }

    
    template <class T>
    class Bucket
    {
    private:
        T *data;
        int size;
        int capacity;
    public:
        Bucket();
        ~Bucket();
        void push_back(const T &);
        T operator[] (int);
        inline int getSize(){return size;};
        inline int getCapacity(){return capacity;};
        void sort();
    };
    
    template <class T>
    Bucket<T>::Bucket()
    {
        size = 0;
        capacity = 10;
        data = new T[capacity];
    }
    template <class T>
    Bucket<T>::~Bucket()
    {
        delete[] data;
        data = NULL;
        size = 0;
        capacity = 0;
    }
    
    template <class T>
    void Bucket<T>::push_back(const T & t)
    {
        if(size == capacity)
        {
            T *tmp = new T[capacity+10];
            capacity += 10;
            for(int i = 0;i<size;i++)
            {
                *(tmp+i) = *(data+i);
            }
            *(tmp+size) = t;
            size++;
            delete []data;
            data = tmp;
            
            
        }
        else
        {
            *(data+size) = t;
            size++;
        }
    }
    
    template <class T>
    T Bucket<T>::operator[](int index)
    {
        if(index >= size || index < 0)
        {
            throw new MyException(index,size);
        }
        else
        {
            return *(data + index);
        }
    }
    template <class T>
    void Bucket<T>::sort()
    {
        MyLib::sort(data, size);
    }

    

};






#endif
