//
//  Employee.cpp
//  204ass3
//
//  Created by Jason Zhou on 13-10-10.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//


#include "Employee.h"
#include <iostream>
#include <sstream>
#include <fstream>
using namespace std;

ostream & operator<<(ostream &out,const Employee& e)
{
    out << e.id << "," << e.name << "," << e.address << "," << e.phone << "," << e.dName << "," << e.sLevel << endl;
    return out;
}

istream & operator>>(istream &in,Employee &e)
{
    in >> e.id;
    //cout << "id" << e.id << endl;
    in.ignore();
    in.getline(e.name,200,',');
    //cout << "name:" << e.name << endl;
    
    in.getline(e.address,200,',');
    //cout << "address:" << e.address << endl;
    in.ignore();
    in >> e.phone;
    in.ignore();
    in.getline(e.dName, 200,',');
    
    in >> e.sLevel;
    //cout << "level:" << e.sLevel << endl;
    in.ignore(100,'\n');
    
    return in;
}

ifstream & operator>>(ifstream &in,Employee &e)
{
    in >> e.id;
    //cout << "id" << e.id << endl;
    in.ignore();
    in.getline(e.name,200,',');
    //cout << "name:" << e.name << endl;
    
    in.getline(e.address,200,',');
    //cout << "address:" << e.address << endl;
    in.ignore();
    in >> e.phone;
    in.ignore();
    in.getline(e.dName, 200,',');
    
    in >> e.sLevel;
    //cout << "level:" << e.sLevel << endl;
    in.ignore(100,'\n');
    
    return in;
}


