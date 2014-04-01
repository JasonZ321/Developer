//
//  LibraryItem.h
//  204ass2
//
//  Created by Jason Zhou on 13-9-17.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#ifndef ___04ass2__LibraryItem__
#define ___04ass2__LibraryItem__

#include <iostream>
#include <string>
using namespace std;


class LibraryItem
{
    friend ostream & operator<< (ostream &,const LibraryItem&);
    friend istream & operator>> (istream &,LibraryItem);
protected:
        std::string title,callNumber,publisher,location,type,year;
public:
    LibraryItem(std::string="",std::string="",std::string="",std::string="",std::string="",std::string="");
    /*inline string getTitle()const{return title;};
    inline string getCallNumber()const{return callNumber;};
    inline string getPublisher()const{return publisher;};
    inline string getLocation()const{return location;};
    inline string get*/
    inline void setType(string type){this->type = type;};
    
};

class Book:public LibraryItem
{
    friend ostream & operator<< (ostream &,const Book&);
    friend istream & operator>> (istream &,Book);
private:
    string author,isbn,subject,edition;
public:
    Book(string="",string="",string="",string="");
};

class Journal:public LibraryItem
{
    friend ostream & operator<< (ostream &,const Journal&);
    friend istream & operator>> (istream &,Journal);
private:
    string chiefEditor,issn,volume,issue;
public:
    Journal(string="",string="",string="",string="");
};
class LibraryItemNode;
typedef LibraryItemNode* nptr;
class LibraryItemNode
{
private:
    LibraryItem *lib;
    nptr next;
public:
    LibraryItemNode(LibraryItem * = NULL);
    inline LibraryItem* getLib()const{return lib;};
    inline nptr getNext()const{return next;};
    inline void setNext(nptr n){next = n;};
    inline void setLib(LibraryItem* l){lib = l;};
    ~LibraryItemNode();
};

#endif /* defined(___04ass2__LibraryItem__) */
