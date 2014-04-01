//
//  LivesViewController.h
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import <UIKit/UIKit.h>
#import "LiveTrip.h"
@interface LivesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) NSManagedObjectContext *managedContext;
// I create 9 arrays for storing values of 9 attributes
@property (strong,nonatomic) NSMutableArray *startOdometerArray;
@property (strong,nonatomic) NSMutableArray *endOdometerArray;
@property (strong,nonatomic) NSMutableArray *startLatitudeArray;
@property (strong,nonatomic) NSMutableArray *endLatitudeArray;
@property (strong,nonatomic) NSMutableArray *startLongtitudeArray;
@property (strong,nonatomic) NSMutableArray *endLongtitudeArray;
@property (strong,nonatomic) NSMutableArray *startTimeArray;
@property (strong,nonatomic) NSMutableArray *endTimeArray;
@property (strong,nonatomic) NSMutableArray *tripType;
@end
