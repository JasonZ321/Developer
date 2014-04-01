//
//  task1Main.cpp
//  204ass3
//
//  Created by Jason Zhou on 13-10-10.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//


#include "MyLib.h"
#include "Employee.h"
#include <fstream>
#include <cstring>
#include <iostream>
using namespace std;
//using namespace MyLib;

template <class T>
void testBucket(string,MyLib::Bucket<T>);
int main()
{
    
    MyLib::Bucket<int> iBucket;
    testBucket("integers",iBucket);
    MyLib::Bucket<double> dBucket;
    testBucket("doubles",dBucket);
    
    Employee e;
    MyLib::Bucket<Employee> eBucket;
    cout << "Input a text file name: ";
    string filename;
    
    cin >> filename;

    fstream inf;
    inf.open(filename.c_str(),ios::in);
    
    cout << "tell:" << inf.tellg() << endl;
    int size = 0;
    while(inf.peek() != EOF)
    {
        size++;
        inf >> e;
        cout << 1 << endl;
        eBucket.push_back(e);
    }
    cout << size << " records loaded" << endl;
    for(int i = 0;i<size;i++)
    {
        cout << eBucket[i];
    }
    inf.close();
    
    cout << endl;
    cout << "Input a subscript value for the employees: ";
    int index;
    cin >> index;
    cout << "The employee is " << endl;
    cout << eBucket[index];
    cout << endl;
    
    cout << "Output binary file name:";
    getline(cin,filename,'\n');
    ofstream outf(filename.c_str());
    for(int i = 0;i<size;i++)
    {
        Employee ee;
        ee = eBucket[i];
        outf.write((char*)(&e), sizeof(Employee));
    }
    
}
template <class T>
void testBucket(string type,MyLib::Bucket<T> b)
{
    
    int number;
    
    cout << "Input number of "<< type << " in the bucket: ";
    cin >> number;
    T *tmp = new T[number];
    cout << "Input " << number << " " << type << ":";
    for(int i = 0;i<number;i++)
    {
        cin >> tmp[i];
    }
    
    for(int i = 0;i<number;i++)
    {
        b.push_back(tmp[i]);
        cout << "Add item " << tmp[i] << " in, the bucket size = " << b.getSize() << ", capacity = " << b.getCapacity() << endl;
    }
    
    b.sort();
    for(int i = 0;i<b.getSize();i++)
    {
        cout << b[i] << " ";
    }
    cout << endl << endl;
    cout << "Input a subscript value for the bucket: ";
    int sub;
    cin >> sub;
    cout << "The element is " << b[sub] << endl << endl;
}