//
//  ItemManage.cpp
//  204ass2
//
//  Created by Jason Zhou on 13-9-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#include "ItemManage.h"
#include <cstdlib>
#include <fstream>
ItemManage::ItemManage(nptr head,nptr tail):head(head),tail(tail)
{
}

ItemManage::~ItemManage()
{
    
    while(head != NULL)
        popFront();
}
void ItemManage::popFront()
{
    nptr tmp = head;
    head = head->getNext();
    delete tmp;
    tmp = NULL;
}
void ItemManage::addNewItem()
{
    string type;
    do
    {
        cout << "Type(B-Book,J-Journal):";
        getline(cin,type,'\n');
        if (type == "B") {
            Book newItem;
            cin>>newItem;
            newItem.setType("B");
            nptr newNode = new LibraryItemNode(&newItem);
            if(head == NULL)
            {
                head = newNode;
                tail = newNode;
            }
            else
            {
                tail->setNext(newNode);
                tail = newNode;
                
            }
        }
        else if(type == "J")
        {
            Journal newItem;
            cin>>newItem;
            newItem.setType("J");
            nptr newNode = new LibraryItemNode(&newItem);
            if(head == NULL)
            {
                head = newNode;
                tail = newNode;
            }
            else
            {
                tail->setNext(newNode);
                tail = newNode;
            }
        }
        else
            cout << "Unknown type." << endl;
    }while(type != "B" && type != "J");
}

void ItemManage::manageItems()
{
    
 
    int c = getMenuChoice();
    while(c != 0)
    {
        while(c != 0 && c!= 1 && c!= 2 && c!=3)
        {
            cout << "Invalid choice." << endl;
            c = getMenuChoice();
        
        }
        switch (c) {
            case 1:
                addNewItem();
                break;
            case 2:
                displayAllItems();
                break;
            case 3:
                saveAllItems();
                break;
            case 0:
                cout << "Bye bye." << endl;
                break;
        }
        if(c != 0)
            c = getMenuChoice();
        
    }
}

int ItemManage::getMenuChoice()
{
    cout << "1. Add a new item. "<< endl;
    cout << "2. Display all items. " << endl;
    cout << "3. Save all items. " << endl;
    cout << "0. Quit. " << endl;
    
    string choose;
    getline(cin,choose, '\n');
    return atoi(choose.c_str());
}

void ItemManage::displayAllItems()const
{
    nptr cur = head;
    while (cur != NULL) {
        cout << *(cur->getLib());
    }
}
void ItemManage::saveAllItems()const
{
    cout << "Input text file name: ";
    char *filename = NULL;
    cin >> filename;
    ofstream outf(filename);
    nptr cur = head;
    while (cur != NULL) {
        outf << *(cur->getLib());
    }
}