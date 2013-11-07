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
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *thumImage;
@property (nonatomic, copy) NSString *bigImage;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *width;
@property (nonatomic, copy) NSString *height;
@property (nonatomic, strong) NSData *thumImageData;
@end
