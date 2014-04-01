//
//  EightBallMode.h
//  lab
//
//  Created by Jason Zhou on 13-8-18.
//  Copyright (c) 2013年 Jason Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EightBallModel : NSObject
{
    //    int *c;
    NSArray *responseArray;
}

@property NSArray *responseArray;
//@property int *c;
+ (NSArray *) initialResponseArray;

- (id) init;

- (id) initWithExtraResponses:(NSArray*) extraResponses;
@end


