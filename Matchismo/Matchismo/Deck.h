//
//  Deck.h
//  Matchismo
//
//  Created by Jason Zhou on 13-11-28.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (Card *)drawRandomCard;
@end
