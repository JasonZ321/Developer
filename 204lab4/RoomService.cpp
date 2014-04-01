#include<iostream>
#include<string>
using namespace std;
class RestaurantMeal
   {
   protected:
      string entree;
      double price;
   public:
       RestaurantMeal(string, double);
       void showRestaurantMeal();
  };
RestaurantMeal::RestaurantMeal(string meal, double pr)
{
    entree = meal;
    price = pr;
}
void RestaurantMeal::showRestaurantMeal()
{
   cout << entree<<" $"<<price<<endl;
}
class HotelService
{
  protected:
    string service;
    double serviceFee;
    int roomNumber;
 public:
   HotelService(string, double, int);
   void showHotelService();
};
HotelService::HotelService(string serv, double fee, int rm)
{
   service = serv;
   serviceFee = fee;
   roomNumber = rm;
}
void HotelService::showHotelService()
{
  cout << service<<" service fee $"<<serviceFee<<
	  " to room #"<<roomNumber<<endl;
}
class RoomServiceMeal : public RestaurantMeal, public HotelService
{
   public:
     RoomServiceMeal(string, double, int);
     void showRoomServiceMeal();
 };
RoomServiceMeal::RoomServiceMeal(string entree, double price, int roomNum) :
   RestaurantMeal(entree, price),HotelService("room service", 4.00, roomNum)
{
}
void RoomServiceMeal::showRoomServiceMeal()
{
    double total = price + serviceFee;
  showRestaurantMeal();
  showHotelService();
  cout<<"Total is $"<<total<<endl;
}

int main()
{
  RoomServiceMeal rs("lots of lettuce",12.99, 102);
    
  cout<<"Room service ordering now:"<<endl;
  rs.showRoomServiceMeal();
}

