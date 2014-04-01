//
//  Card.h
//  stanford2014Assignments1
//
//  Created by Jason Zhou on 14-3-13.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;
- (int)match:(NSArray *)otherCards;
@end