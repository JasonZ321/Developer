//
//  EightBallMode.m
//  lab
//
//  Created by Jason Zhou on 13-8-18.
//  Copyright (c) 2013年 Jason Zhou. All rights reserved.
//

#import "EightBallMode.h"

@implementation EightBallModel

@synthesize responseArray;

+ (NSArray *)initialResponseArray{
    /*
     responesArray[0]= @"Without a Doubt";
     responesArray[1]= @"Can't predict now";
     responesArray[2]= @"My reply is no";
     */
    
    NSArray *tmpArray = [[NSArray alloc]init];
    tmpArray = [NSArray arrayWithObjects:@"Without a Doubt",@"Can't predict now",@"My reply is no",nil];
    return tmpArray;
}

-(id) init{
    
    self = [super init];
    
    if(self != nil){
        responseArray = [[self class] initialResponseArray];
    }
    return self;
    
}

- (id) initWithExtraResponses:(NSArray *)extraResponses{
    self = [super init];
    if(self != nil){
        
        responseArray = [[self class] initialResponseArray];
        responseArray = [responseArray arrayByAddingObjectsFromArray:extraResponses];
        
    }
    return self;
}

@end
