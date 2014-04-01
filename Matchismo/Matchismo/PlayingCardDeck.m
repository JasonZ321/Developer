//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Jason Zhou on 13-11-28.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"
@implementation PlayingCardDeck
- (id)init
{
    self = [super init];
    
    if (self) {
        for (NSString *suit in [PlayingCard validSuits]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++) {
                PlayingCard *card = [[PlayingCard alloc]init];
                card.rank = rank;
                card.suit = suit;
                //NSLog(@"%@",card.suit);
                [self addCard:card atTop:YES];

            }
        }
    }
    return self;
}
@end
