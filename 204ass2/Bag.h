//
//  Bag.h
//  204ass2
//
//  Created by Jason Zhou on 13-9-22.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#ifndef ___04ass2__Bag__
#define ___04ass2__Bag__

#include <iostream>

namespace MYLIB
{
    template<class T>class Bag;
    template<class T>
    std::ostream& operator<<(std::ostream&,const Bag<T>&);
    
    template<class T>
    class Bag
    {
        friend std::ostream& operator<< <T> (std::ostream&, const Bag<T>&);
    public:
        Bag(int);
        Bag();
        
        ~Bag();
        void add(T);
        bool remove(T);
        Bag operator+(const Bag&);
        Bag operator=(const Bag&);
    private:
        T* array;
        int size;

    };
}

#endif /* defined(___04ass2__Bag__) */
