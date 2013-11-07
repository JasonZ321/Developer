//
//  Annotation.h
//  Flickr
//
//  Created by Jason Zhou on 13-10-19.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface Annotation : NSObject<MKAnnotation>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; // location
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *thumImage;  // thumb image url string
@property (nonatomic, copy) NSString *bigImage;   // original image url string
@property (nonatomic, copy) NSString *address;    // where photo taken
@property (nonatomic, strong) NSData *thumImageData; // thumb image's data
@end
