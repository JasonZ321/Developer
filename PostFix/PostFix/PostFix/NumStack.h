/*
 Student Name: Jiasheng Zhou
 Student Id: 4022828
 */

#import <Foundation/Foundation.h>
@protocol StackDelegate<NSObject>
@required
-(void)pushToScreen;
-(void)popToScreen:(NSNumber *)aNum;
-(void)divideByZero;
-(void)clearStack;
@end

@interface NumStack:NSObject{
    id<StackDelegate> delegate;
}
@property (strong,nonatomic) id<StackDelegate>delegate;
@property (strong,nonatomic)NSMutableArray *numbers;
@property (nonatomic)int count;
@property (nonatomic)int index;

-(void)push:(NSNumber *)aNum;
-(NSNumber*)pop: (NSString *)operation;
-(void)clear;


@end
