/*
 student name: Jiasheng Zhou
 Id:4022828
 */
#include<iostream>
using namespace std;
template<class T>
class CSL       // CommaSeparatedList
{
private:
    int size;
    T *data;
public:
    CSL(T *d, int s);
    void showList();
};
template <class T>
CSL<T>::CSL(T *d, int s): data(d),size(s){};

template<class T>
void CSL<T>::showList()
{
    cout<<"Comma separated list:"<<endl;
    for(int x = 0; x < size; ++x)
    {
        cout<<data[x];
        if(x != size - 1)
            cout<<", ";
    }
    cout<<endl<<endl;
}
class Video
{
    friend ostream& operator<<(ostream&, const Video &);
private:
    string title;
    double price;
public:
    void setVideo(string, double);
};
void Video::setVideo(string VideoTitle, double pr)
{
    title = VideoTitle;
    price = pr;
}
    ostream& operator<<(ostream& out, const Video &aVideo)
    {
        out<<aVideo.title<<" sells for $"<<aVideo.price;
        return out;
    }
    
    class Customer
    {
        friend ostream& operator<<(ostream&, const Customer &);
    private:
        string name;
        double balDue;
    public:
        void setCustomer(string, double);
    };
    void Customer::setCustomer(string CustomerName, double pr)
    {
        name = CustomerName;
        balDue = pr;
    }
    ostream& operator<<(ostream& out, const Customer &aCustomer)
    {
        out<<aCustomer.name<<" owes $"<<aCustomer.balDue;
        return out;
    }


    int main()
    {
        int CSL_Size;
        int someInts[] = {12,34,55, 77, 99};
        double someDoubles[] = {11.11, 23.44, 44.55, 123.66};
        Video someVideos[2];
        someVideos[0].setVideo("Bob the Builder", 12.50);
        someVideos[1].setVideo("Thomas the Tank Engine", 15.00);
        Customer someCustomers[6];
        someCustomers[0].setCustomer("Zaps", 23.55);
        someCustomers[1].setCustomer("Martin", 155.77);
        someCustomers[2].setCustomer("Fine",333.88);
        someCustomers[3].setCustomer("Torrence",123.99);
        someCustomers[4].setCustomer("Richard",20.06);
        someCustomers[5].setCustomer("Curtin",56999.19);
        CSL_Size = sizeof(someInts)/sizeof(someInts[0]);
        CSL<int> CSL_Integers(someInts,CSL_Size);
        CSL_Size = sizeof(someDoubles)/sizeof(someDoubles[0]);
        CSL<double> CSL_Doubles(someDoubles,CSL_Size);
        CSL_Size = sizeof(someVideos)/sizeof(someVideos[0]);
        CSL<Video> CSL_Videos(someVideos,CSL_Size);
        CSL_Size = sizeof(someCustomers)/sizeof(someCustomers[0]);
        CSL<Customer> CSL_Customers(someCustomers,CSL_Size);
        CSL_Integers.showList();
        CSL_Doubles.showList();
        CSL_Videos.showList();
        CSL_Customers.showList();
    }
    
    
