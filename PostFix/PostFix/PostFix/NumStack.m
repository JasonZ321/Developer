//
//  NumStack.m
//  PostFix
//
//  Created by Jason Zhou on 13-8-27.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "NumStack.h"

@implementation NumStack
@synthesize delegate;
@synthesize numbers;
@synthesize count;
-(id)init
{
    if(self = [super init]){
        numbers = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)push:(NSNumber *)aNum
{
    [numbers addObject:aNum];
    count = numbers.count;
    if(delegate != nil)
        [delegate pushToScreen:aNum];
    
}
-(NSNumber*)pop: (NSString *)operation
{
    NSNumber *aNum = nil;
     if(count > 1){
         
     
         if([operation isEqualToString:@"+"]){
             aNum = [NSNumber numberWithFloat:([[numbers objectAtIndex:count-1] floatValue] + [[numbers objectAtIndex:count-2] floatValue])];
         }else if ([operation isEqualToString:@"-"]){
             aNum = [NSNumber numberWithFloat:([[numbers objectAtIndex:count-1] floatValue] -    [[numbers objectAtIndex:count-2] floatValue])];
         }else if ([operation isEqualToString:@"*"]){
             aNum =[NSNumber numberWithFloat:([[numbers objectAtIndex:count-1] floatValue] * [[numbers objectAtIndex:count-2] floatValue])];
         }else{
             aNum = [NSNumber numberWithFloat:([[numbers objectAtIndex:count-2] floatValue] / [[numbers objectAtIndex:count-1] floatValue])];
         }
        
   
    
        
        [numbers removeLastObject];
         [numbers removeLastObject];
         [numbers addObject:aNum];
        count = numbers.count;
         if(delegate != nil && aNum != nil)
             [delegate popFromScreen:aNum];
        
    }
    return aNum;
    
}
-(void)clear
{
    [numbers removeAllObjects];
    count = 0;
}
@end
