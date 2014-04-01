//
//  LiveTripViewController.h
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import <UIKit/UIKit.h>
#import "LiveTrip.h"
#import "CoreLocation/CoreLocation.h"
@interface LiveTripViewController : UIViewController<UIActionSheetDelegate,UIAlertViewDelegate,CLLocationManagerDelegate>
{
    
}
@property (strong,nonatomic) LiveTrip* livetrip;
@property (strong,nonatomic) CLLocationManager* location;
@property (strong,nonatomic) NSManagedObjectContext *managedContext;
@end
