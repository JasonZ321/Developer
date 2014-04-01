//
//  LiveTrip.h
//  LiveTrip
//
//  Student Id: 4022828
//  Student Name: Jiasheng Zhou

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface LiveTrip : NSManagedObject

@property (nonatomic, retain) NSNumber * endOdometer;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSNumber * startOdometer;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSNumber * tripType;
@property (nonatomic, retain) NSNumber * startLatitude;
@property (nonatomic, retain) NSNumber * endLatitude;
@property (nonatomic, retain) NSNumber * startLongtitude;
@property (nonatomic, retain) NSNumber * endLongtitude;

@end
