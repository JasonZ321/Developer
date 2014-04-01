//
//  ItemManage.h
//  204ass2
//
//  Created by Jason Zhou on 13-9-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#ifndef ___04ass2__ItemManage__
#define ___04ass2__ItemManage__

#include <iostream>
#include "LibraryItem.h"
using namespace std;
class ItemManage
{
private:
    nptr head,tail;
public:
    ItemManage(nptr=NULL,nptr=NULL);
    ~ItemManage();
    void popFront();
    int getMenuChoice();
    void manageItems();
    void addNewItem();
    void displayAllItems()const;
    void saveAllItems()const;
};
#endif /* defined(___04ass2__ItemManage__) */
