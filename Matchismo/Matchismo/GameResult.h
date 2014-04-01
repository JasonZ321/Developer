//
//  GameResult.h
//  Matchismo
//
//  Created by Jason Zhou on 13-12-10.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameResult : NSObject
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic)NSDate *end;
@property (readonly, nonatomic)NSTimeInterval duration;
@property (nonatomic) int score;
+ (NSArray *)allGameResults;
@end
