//
//  CardMatchingGame.m
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-20.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card

@end
@implementation CardMatchingGame
- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc]init];
    return _cards;
}

- (NSMutableArray *)history
{
    if (!_history) {
        _history = [[NSMutableArray alloc]init];
    }
    return _history;
    
}
- (void)setMessage:(NSString *)message
{
    _message = message;
    if ([message length] != 0) {
        [self.history addObject:message];
    }
}
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init]; //call super initialization
    if (self){
        for (int i = 0; i < count ;i++)
        {
            Card *card = [deck drawRandomCard];
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

static const int MISMATCH_PENALTY  = 2;
static const int COST_TO_CHOOSE = 1;
static const int MATCH_BONUS = 4;
- (void)chooseCardAtIndex:(NSInteger)index
{
    BOOL hasMessage = NO;
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            self.message = @"";
        }
        else{
            // match agains another card.
            for (Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchSocre = [card match:@[otherCard]];
                    if (matchSocre){
                        self.score += matchSocre * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                        self.message = [NSString stringWithFormat:@"Matched %@ %@ for %d points",card.contents,otherCard.contents,matchSocre * MATCH_BONUS];
                        
                        hasMessage = YES;
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        self.message = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                        
                        hasMessage = YES;
                    }
                    break;
                }
               
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if (!hasMessage) {
                self.message = card.contents;
                
            }
        }
        
    }
}
- (void)chooseCardAtIndexFor3:(NSInteger)index
{
    BOOL hasMessage = NO;
    int numOfMatchedCard = 1;
    Card *card = [self cardAtIndex:index];
    Card *otherCard2 = nil;
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
            
        }else{
            for (Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchSocre = [card match:@[otherCard]];
                    
                    if (matchSocre && numOfMatchedCard == 1){
                        numOfMatchedCard = 2;
                        
                        otherCard2 = otherCard;
                        otherCard2.chosen = YES;
                        continue;
                        
                    }else if(matchSocre && numOfMatchedCard == 2){
                        self.score += matchSocre * MATCH_BONUS * 2;
                        card.matched = YES;
                        otherCard.matched = YES;
                        otherCard2.matched = YES;
                        self.message = [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points",card.contents, otherCard2.contents,otherCard.contents,MATCH_BONUS * matchSocre * 2];
                        hasMessage = YES;
                    }else if(numOfMatchedCard == 2 && matchSocre == 0){
                        
                        otherCard.chosen = NO;
                        otherCard2.chosen = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.message = [NSString stringWithFormat:@"%@ %@ %@ don't match! %d point penalty!",card.contents, otherCard2.contents,otherCard.contents,MISMATCH_PENALTY];
                        hasMessage = YES;
                    }else{
                        
                        otherCard.chosen = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.message = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!",card.contents,otherCard.contents,MISMATCH_PENALTY];
                        hasMessage = YES;
                        
                    }
                   
                }
                
            }
           
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            if (!hasMessage) {
                 self.message = card.contents;
            }
           

            
        }
    }

}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (instancetype)init
{
    return nil;
}
@end
