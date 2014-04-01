//
//  ComplexNumber.cpp
//  204a2
//
//  Created by Jason Zhou on 13-9-3.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.

#include<iostream>

using namespace std;

class ComplexNumber
{
    friend istream & operator>>(istream&,ComplexNumber&);
    friend ostream & operator<<(ostream&,ComplexNumber);
    friend ComplexNumber operator*(double other,ComplexNumber obj);
private:
    double real,imaginary;
public:
    ComplexNumber();
    ComplexNumber(double,double);
    ComplexNumber operator+(ComplexNumber other);
    ComplexNumber operator+=(ComplexNumber other);
    ComplexNumber operator-(ComplexNumber other);
    ComplexNumber operator-=(ComplexNumber other);
    ComplexNumber operator*(ComplexNumber other);
    ComplexNumber operator*(double other);
    ComplexNumber operator/(ComplexNumber other);
    ComplexNumber operator/=(ComplexNumber other);
};



int main()
{
    ComplexNumber c1,c2,c3;
    double c;
    cout <<"first complex:";
    cin >> c1;
    cout << "second complex:";
    cin >> c2;
    cout << c2;
    try
    {
        c3 = c1/c2;
    }catch(const string message)
    {
        cout << "11" << endl;
        cout << message << endl;
    }
    cout << c3;
    
    
}



istream &operator>>(istream& is,ComplexNumber &obj)
{
    is >> obj.real >> obj.imaginary;
    return is;
}
ostream &operator<<(ostream& os,ComplexNumber obj)
{
    if (obj.real != 0)
    {
        os << obj.real;
        if (obj.imaginary > 0)
        {
            os << "+" << obj.imaginary << "i" << endl;
        }
        else if (obj.imaginary < 0)
        {
            os << obj.imaginary << "i" << endl;
        }
    }
    else
    {
        os << obj.imaginary << "i" << endl;
    }
    return os;
    
}
ComplexNumber::ComplexNumber():real(0),imaginary(0)
{
}

ComplexNumber::ComplexNumber(double r,double i):real(r),imaginary(i)
{
}

ComplexNumber ComplexNumber::operator+(ComplexNumber other)
{
    ComplexNumber tmp(real+other.real,imaginary+other.imaginary);
    return tmp;
    
}

ComplexNumber ComplexNumber::operator+=(ComplexNumber other)
{
    real += other.real;
    imaginary += other.imaginary;
    return *this;
}

ComplexNumber ComplexNumber::operator-(ComplexNumber other)
{
    ComplexNumber tmp(real-other.real,imaginary-other.imaginary);
    return tmp;
}

ComplexNumber ComplexNumber::operator-=(ComplexNumber other)
{
    real -= other.real;
    imaginary -= other.imaginary;
    return *this;
}

ComplexNumber ComplexNumber::operator*(ComplexNumber other)
{
    double tmp_real,tmp_imaginary;
    tmp_real = real * other.real - imaginary * other.imaginary;
    tmp_imaginary = real * other.imaginary + imaginary * other.real;
    ComplexNumber tmp(tmp_real,tmp_imaginary);
    return tmp;
}

ComplexNumber ComplexNumber::operator*(double other)
{
    ComplexNumber tmp(other*real,other*imaginary);
    return tmp;
}
ComplexNumber operator*(double other,ComplexNumber obj)
{
    ComplexNumber tmp(other*obj.real,other*obj.imaginary);
    return tmp;
}

ComplexNumber ComplexNumber::operator/(ComplexNumber other)
{
    if (other.real == 0 && other.imaginary == 0)
    {
        throw ("divide by zero!");
    }
    double tmp_real,tmp_imaginary;
    tmp_real = (real*other.real + imaginary*other.imaginary)/(other.real*other.real + other.imaginary*other.imaginary);
    tmp_imaginary = (imaginary*other.real - real*other.imaginary)/(other.real*other.real + other.imaginary*other.imaginary);
    ComplexNumber tmp(tmp_real,tmp_imaginary);
    return tmp;
}

ComplexNumber ComplexNumber::operator/=(ComplexNumber other)
{
    if (other.real == 0 && other.imaginary == 0)
    {
        throw ("divide by zero!");
    }
    double tmp_real,tmp_imaginary;
    tmp_real = (real*other.real + imaginary*other.imaginary)/(other.real*other.real + other.imaginary*other.imaginary);
    tmp_imaginary = (imaginary*other.real - real*other.imaginary)/(other.real*other.real + other.imaginary*other.imaginary);
    real = tmp_real;
    imaginary = tmp_imaginary;
    ComplexNumber tmp(real,imaginary);
    return tmp;
}















