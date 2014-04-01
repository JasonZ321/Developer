/*
 student name: Jiasheng Zhou
 Id:4022828
 */

#include<iostream>
#include<string>
using namespace std;
#define reverse(x)(-(x))
template <class T>
T subtract(T x, T y)
{
    T diff = (x - y);
    return diff;
}

class Person
{
    friend ostream& operator <<(ostream&,const Person &);
private:
    string lastName;
    string firstName;
    int age;
public:
    void setValues(string, string, int);
    Person operator-(Person);
    void operator=(const Person &);
};

ostream& operator<<(ostream& out, const Person &per)
{
    out<< per.firstName<<" "<<per.lastName<<" "<< per.age<<" weeks old";
    return out;
}
void Person::setValues(string last, string first, int ageIn)
{
    lastName = last;
    firstName = first;
    age = ageIn;
}
Person Person::operator-(Person p)
{
    Person temp;
    temp.lastName = "Difference";
    temp.firstName = "Age";
    
    temp.age = age - p.age;
    temp.age = temp.age<0?reverse(temp.age):temp.age;
    return temp;
}
void Person::operator=(const Person &p){
    lastName = p.lastName;
    firstName = p.firstName;
    age = p.age;
    
}

int main()
{
    int a = 7, b = 26, c;
    double d = 39.25, e = 2.01, f;
    Person g, h, i;
    g.setValues("the Builder","Alice",50);
    h.setValues("the Engine","Edward",90);
    c = subtract(a,b);
    f = subtract(d, e);
    i = subtract(g,h);
    cout<<c<<endl;
    cout<<f<<endl;
    cout<<i<<endl;
    
    
    
}