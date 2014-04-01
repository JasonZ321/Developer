//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jason Zhou on 13-11-29.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
@property (readwrite, nonatomic) int score;
@property (strong, nonatomic) NSMutableArray *cards; // of card
@end
@implementation CardMatchingGame
#define MATCH_B
- (NSMutableArray *)cards
{
    if(_cards)
        _cards = [[NSMutableArray alloc]init];
    return _cards;
}
- (id) initWithCardCount:(NSUInteger)count
               usingDeck: (Deck *)deck
{
    self = [super init];
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            NSLog(@"%@",card.contents);
            if (card) {
                self.cards[i] = card;
            }else{
                self = nil;
                break;
            }
            
        }
    }
    return self;
}
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1
- (void)flipCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    
    if (card && !card.isUnAvailable){
        if(!card.isFaceUp){
            for (Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnAvailable){
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore){
                        card.unAvailable = YES;
                        otherCard.unAvailable = YES;
                        self.score += matchScore * MATCH_BONUS;
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        
        card.faceUp = !card.isFaceUp;
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}
@end
