//
//  LibraryItem.cpp
//  204ass2
//
//  Created by Jason Zhou on 13-9-17.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#include "LibraryItem.h"
using namespace std ;
ostream& operator<< (ostream &os,const LibraryItem &obj)
{
    os << obj.type << ";" << obj.title << ";" << obj.callNumber << ";" << obj.publisher <<  ";" << obj.location << endl;
    return os;
}
istream& operator>> (istream &is,LibraryItem obj)
{
    
    cout << "Title:";
    is >> obj.title;
    cout << "Call number:";
    is >> obj.callNumber;
    cout << "Publisher:";
    is >> obj.publisher;
    cout << "Location:";
    is >> obj.location;
    cout << "Year:";
    is >> obj.year;
    return is;
    
}

ostream& operator<< (ostream &os,const Book &obj)
{
    os << static_cast<const LibraryItem&>(obj);
    os << obj.author << ";" << obj.isbn << ";" << obj.subject << ";" << obj.edition << ";" << obj.year << endl;
    return os;
}
istream& operator>>(istream &is,Book obj)
{
    is >> static_cast<LibraryItem>(obj);
    cout << "Authors:";
    is >> obj.author;
    cout << "ISBN:";
    is >> obj.isbn;
    cout << "Subject:";
    is >> obj.subject;
    cout << "Edition:";
    is >> obj.edition;
    return is;
}

ostream& operator<< (ostream &os,const Journal &obj)
{
    os << static_cast<const LibraryItem&>(obj);
    os << obj.chiefEditor << ";" << obj.issn << ";" << obj.volume << ";" << obj.issue << ";" << obj.year << endl;
    return os;
}

istream& operator>> (istream &is,Journal obj)
{
    is >> static_cast<LibraryItem>(obj);
    cout << "Chief Editor:";
    is >> obj.chiefEditor;
    cout << "ISSN:";
    is >> obj.issn;
    cout << "Volume:";
    is >> obj.volume;
    cout << "Issue:";
    is >> obj.issue;
    return is;
}

LibraryItem::LibraryItem(string title,string callNumber,string publisher,string location,string type,string year)
:title(title),callNumber(callNumber),publisher(publisher),location(location),type(type),year(year)
{
}

Book::Book(string author,string isbn,string subject,string edition)
:author(author),isbn(isbn),subject(subject),edition(edition)
{
}

Journal::Journal(string chiefEditor,string issn,string volume,string issue)
:chiefEditor(chiefEditor),issn(issn),volume(volume),issue(issue)
{
}

LibraryItemNode::LibraryItemNode(LibraryItem *lib):lib(lib)
{
    next = NULL;
}
LibraryItemNode::~LibraryItemNode()
{
    delete lib;
    lib = NULL;
    next = NULL;
}


