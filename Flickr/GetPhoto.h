//
//  GetPhoto.h
//  Flickr
//
//  Created by Jason Zhou on 13-10-21.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetPhoto : NSObject
@property (strong, nonatomic) NSURLConnection *connection;
@property (strong, nonatomic) NSURLRequest *request;
@property (strong, nonatomic) NSMutableData *data;
- (id)initWithRequest:(NSURLRequest *)urlRequest;
- (void)start;
@end
