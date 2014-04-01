//
//  Employee.h
//  204ass3
//
//  Created by Jason Zhou on 13-10-10.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#ifndef ___04ass3__Employee__
#define ___04ass3__Employee__

#include <iostream>

class Employee
{
    friend std::ifstream& operator>>(std::ifstream &,Employee&);
    friend std::ostream& operator<<(std::ostream &,const Employee &);
    friend std::istream& operator>>(std::istream &,Employee&);
private:
    int id;
    char name[30];
    char address[100];
    int phone;
    char dName[30];
    int sLevel;

    

};

#endif /* defined(___04ass3__Employee__) */
