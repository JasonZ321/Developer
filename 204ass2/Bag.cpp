//
//  Bag.cpp
//  204ass2
//
//  Created by Jason Zhou on 13-9-22.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#include "Bag.h"
#include <iostream>
using namespace std;
using namespace MYLIB;
template<class T>
Bag<T>::Bag()
{
    size = 0;
    array = NULL;
}
template<class T>
Bag<T>::Bag(int n)
{
    size= n;
    array = new T[size];
};
template<class T>
Bag<T>::~Bag()
{
    delete array;
    array = NULL;
    size = 0;
};

template<class T>
void Bag<T>::add(T num)
{
    T* tmp = new T[size + 1];
    for(int i = 0;i<size;i++)
    {
        *(tmp+i) = *(array + i);
    }
    *(tmp + size) = num;
    delete array;
    array = tmp;
    size++;
}

template<class T>
bool Bag<T>::remove(T num)
{
    int index = 0;
    for(;index<size;index++)
    {
        if(*(array+index) == num)
            break;
    }
    if(size == index)
        return false;
    else
    {
        *(array + index) = *(array + size - 1);
        size--;
        return true;
    }
}

template<class T>
Bag<T> Bag<T>::operator=(const Bag<T> &other)
{
    size = other.size;
    array = new T[size];
    for(int i = 0;i<size;i++)
    {
        *(array + i) = *(other.array + i);
    }
}

template<class T>
Bag<T> Bag<T>::operator+(const Bag<T> &other)
{
    /*
    
    T *new_array = new T[new_size];
    */
    int new_size = size + other.size;
    Bag<T> b(new_size);
    b.array = new T[new_size];
    for(int i = 0;i<size;i++)
    {
        *(b.array + i) = *(array + i);
    }
    for(int i = size;i<new_size;i++)
    {
        *(b.array + i) = *(other.array + i - size);
    }
    return b;
    
}
template<class T>
ostream& operator<<(ostream& os,const Bag<T>&obj)
{
    for(int i = 0;i<obj.size;i++)
    {
        os << *(obj.array + i) << " ";
    }
}
