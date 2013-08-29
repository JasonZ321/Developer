//
//  NumStack.h
//  PostFix
//
//  Created by Jason Zhou on 13-8-27.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol StackDelegate<NSObject>
@required
-(void)pushToScreen:(NSNumber *)aNum;
-(NSNumber *)popFromScreen:(NSNumber *)aNum;

@end

@interface NumStack:NSObject{
    id<StackDelegate> delegate;
}
@property (strong,nonatomic) id<StackDelegate>delegate;
@property (strong,nonatomic)NSMutableArray *numbers;
@property (nonatomic)int count;

-(void)push:(NSNumber *)aNum;
-(NSNumber*)pop: (NSString *)operation;
-(void)clear;


@end
