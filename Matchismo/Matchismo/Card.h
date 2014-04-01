//
//  Card.h
//  Matchismo
//
//  Created by Jason Zhou on 13-11-28.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong,nonatomic) NSString *contents;
@property (nonatomic,getter = isFaceUp) BOOL faceUp;
@property (nonatomic,getter = isUnAvailable) BOOL unAvailable;

- (int) match:(NSArray *)otherCards;
@end
