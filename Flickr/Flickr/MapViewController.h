//
//  MapViewController.h
//  Flickr
//
//  Created by Jason Zhou on 13-10-18.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "AFHTTPRequestOperation.h"

#import "Annotation.h"
#import "AFNetworking.h"
#import "AFHTTPRequestOperationManager.h"
@interface MapViewController : UIViewController<MKMapViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *label;

@property (strong, nonatomic) NSString *placeId;
@property (strong, nonatomic) NSString *tags;
@property (strong, nonatomic) NSNumber *latitude;
@property (strong, nonatomic) NSNumber *longitude;
@property (strong, nonatomic) NSURLConnection *connection;

@end
