//
//  PostFixViewController.m
//  PostFix
//
//  Created by Jason Zhou on 13-8-27.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "PostFixViewController.h"

@interface PostFixViewController ()

- (IBAction)number:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UILabel *answer;
@property (nonatomic)BOOL hasPoint;
- (IBAction)clear:(UIButton *)sender;
- (IBAction)push:(UIButton *)sender;
- (IBAction)pop:(UIButton *)sender;



@end

@implementation PostFixViewController
@synthesize stack;
-(void)pushToScreen:(NSNumber *)aNum{
    NSLog(@"Push: %@",aNum);
}
-(NSNumber*)popFromScreen:(NSNumber *)aNum{
    NSLog(@"Pop: %@",aNum);
    return aNum;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // self.background_view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background.png"]];
    self.answer.text = [[NSString alloc]init];
    self.hasPoint = NO;
    stack = [[NumStack alloc]init];
    [stack setDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)number:(UIButton *)sender {
    
    switch ([sender tag]) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            self.answer.text = [self.answer.text stringByAppendingFormat:@"%d",[sender tag]];
            break;
        case 10:
            self.answer.text = [self.answer.text stringByAppendingFormat:@"%d",0];
            break;
        case 11:
            if (self.hasPoint == NO) {
                self.answer.text = [self.answer.text stringByAppendingString:@"."];
                self.hasPoint = YES;
            }
                        
        default:
            break;
    }
}


- (IBAction)clear:(UIButton *)sender {
    
    if([sender tag] == 12){
        self.answer.text = @"";
    }
}


- (IBAction)pop:(UIButton *)sender {
    NSString *operation = nil;
    switch ([sender tag]) {
        case 1:
            operation = @"+";
            break;
        case 2:
            operation = @"-";
            break;
        case 3:
            operation = @"*";
            break;
        case 4:
            operation = @"/";
            break;
            
        default:
            break;
    }
    [stack pop:operation];
    
}


- (IBAction)push:(UIButton *)sender {
    NSNumber *aNum = [NSNumber numberWithFloat:[self.answer.text floatValue]];
    if([self.answer.text length] > 0){
        [stack push:aNum];
        self.answer.text = @"";
        self.hasPoint = NO;
    }
}

@end