//
//  GetPhoto.m
//  Flickr
//
//  Created by Jason Zhou on 13-10-21.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "GetPhoto.h"

@implementation GetPhoto

- (id)initWithRequest:(NSURLRequest *)urlRequest
{
    self = [super init];
    if (self) {
        self.request = urlRequest;
    }
    NSLog(@"init");
    return self;
}

- (void)start
{
    self.connection = [[NSURLConnection alloc] initWithRequest:self.request delegate:self startImmediately:NO];
    NSLog(@"start");
    [self.connection start];

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	assert(self.data==nil);
	self.data = [[NSMutableData alloc] init];
     NSLog(@"data: %@", self.data);
}
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)data
{
    //self.recieved = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    [self.data appendData:data];
     NSLog(@"data: %@", self.data);
    // NSError *e = nil;
    //self.jsonArray = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers error: &e];
    // NSLog(@"array: %@",self.jsonArray);
    
}
- (void) connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"data: %@", self.data);
}



@end

