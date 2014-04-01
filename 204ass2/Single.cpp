//
//  Single.cpp
//  204ass2
//
//  Created by Jason Zhou on 13-9-22.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//
#include <iostream>
#include <iomanip>
using namespace std;
class Single
{
public:
    static Single* Instance();
    static void show(){cout << instance << endl;};
    static void TidyUp();
private:
    static Single* instance;
};
Single* Single::instance = 0;
Single* Single::Instance()
{
    if (instance == 0)
        instance = new Single();
    return instance;
}
void Single::TidyUp()
{
    delete instance;
    instance = 0;
}
int main()
{
    int choice = 0;
    Single *s = NULL;
    int attempts = 0;
    do {
        
        cout << "Instantiation attempts: " << attempts << endl;
        cout << "The current address:" ;
        s->show();
        cout << "Enter 2 to create a Singleton. " << endl;
        cout << "Enter 1 to destroy a Singleton. " << endl;
        cout << "Enter 0 to stop. " << endl;
        
        cin >> choice;
        if(choice == 2)
        {
            s = Single::Instance();
            attempts++;
        }
        if(choice == 1)
        {
            s->TidyUp();
            delete s;
            s = NULL;
            
        }
    } while (choice != 0);
    cout << "Instantiation attempts: " << attempts << endl;
    cout << "The current address:" << hex << s << endl;
}