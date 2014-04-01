//
//  Card.m
//  Matchismo
//
//  Created by Jason Zhou on 13-11-28.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "Card.h"
@interface Card()
@end
@implementation Card
- (int) match:(NSArray *)otherCards
{
    int score = 0;
    for (Card *card in otherCards)
    {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    } 
    return score;
}
- (void)setUnAvailable:(BOOL)unAvailable
{
    _unAvailable = unAvailable;
}

@end
