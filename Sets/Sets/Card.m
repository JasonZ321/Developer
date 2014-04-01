//
//  Card.m
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-13.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//
#import "Card.h"
@interface Card()

@end
@implementation Card
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1; }
    }
    return score;
}
@end