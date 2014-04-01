//
//  CardMatchingGame.h
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-20.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
@interface CardMatchingGame : NSObject

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck: (Deck *)deck;

- (void)chooseCardAtIndex: (NSInteger)index;
- (void)chooseCardAtIndexFor3:(NSInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSMutableArray *history;


@end
