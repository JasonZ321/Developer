/*
 Student Name: Jiasheng Zhou
 Student Id: 4022828
 */

#import "NumStack.h"

@implementation NumStack
@synthesize delegate;
@synthesize numbers;
@synthesize count;
-(id)init
{
    if(self = [super init]){
        // initialize this numbers array
        numbers = [[NSMutableArray alloc]init];
    }
    return self;
}
-(void)push:(NSNumber *)aNum
{
    [numbers addObject:aNum];
    count = numbers.count;
    if(delegate != nil);
        [delegate pushToScreen];
    
}
-(NSNumber *)pop: (NSString *)operation
{
    NSNumber *aNum = nil;
    // if count is smaller than 2, when pop doesn't cause any action
     if(count > 1){
         
     
         if([operation isEqualToString:@"+"]){
             aNum = [NSNumber numberWithFloat:([[numbers objectAtIndex:count-1] floatValue] + [[numbers objectAtIndex:count-2] floatValue])];
         }else if ([operation isEqualToString:@"-"]){
             aNum = [NSNumber numberWithFloat:([[numbers objectAtIndex:count-1] floatValue] -    [[numbers objectAtIndex:count-2] floatValue])];
         }else if ([operation isEqualToString:@"*"]){
             aNum =[NSNumber numberWithFloat:([[numbers objectAtIndex:count-1] floatValue] * [[numbers objectAtIndex:count-2] floatValue])];
         }else{
             // if the divider is zero, assign aNum with the second last value in stack
             // then remove last two value and add aNum into stack, it has the same result with
             // only remove the last one.
             if ([[numbers objectAtIndex:count-1] floatValue] == 0.0) {
                 aNum = [NSNumber numberWithFloat:[[numbers objectAtIndex:count-2] floatValue]];
                 // call divide by zero use delegation
                 [delegate divideByZero];
             }else{
                 aNum = [NSNumber numberWithFloat:([[numbers objectAtIndex:count-2] floatValue] / [[numbers objectAtIndex:count-1] floatValue])];
             }
             
         }
        
        // remove last two value and add a new one.
        [numbers removeLastObject];
        [numbers removeLastObject];
        [numbers addObject:aNum];
        count = numbers.count;    //update count
         
        if(delegate != nil && aNum != nil)
        {
            [delegate popToScreen:aNum];
            //every time after popToScreen, call pushToScreen for updating screen
            [delegate pushToScreen];
        }
        
    }
    return aNum;
    
}
// remove all the value in stack.
-(void)clear
{
    [numbers removeAllObjects];
    [delegate clearStack];
    count = 0;
}
@end
