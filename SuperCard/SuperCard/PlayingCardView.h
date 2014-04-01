//
//  PlayingCardView.h
//  SuperCard
//
//  Created by Jason Zhou on 13-12-11.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView
@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

@property (nonatomic) BOOL faceUp; 
@end
