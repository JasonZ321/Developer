//
//  PlayingCard.h
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-13.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import "Card.h"
@interface PlayingCard : Card
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;
@end