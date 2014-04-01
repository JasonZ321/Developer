//
//  Deck.h
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-13.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;
- (Card *)drawRandomCard;
@end
