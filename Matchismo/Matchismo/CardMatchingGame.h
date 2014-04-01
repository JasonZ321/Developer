//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jason Zhou on 13-11-29.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"
@interface CardMatchingGame : NSObject

// designated initializer
- (id) initWithCardCount:(NSUInteger)count
               usingDeck: (Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@end
