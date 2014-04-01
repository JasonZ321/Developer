//
//  lab2ViewController.m
//  lab
//
//  Created by Jason Zhou on 13-8-18.
//  Copyright (c) 2013年 Jason Zhou. All rights reserved.
//

#import "lab2ViewController.h"
#import "EightBallMode.h"
@interface lab2ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *ball;
@property (strong, nonatomic) IBOutlet UIImageView *backGround;
@property (strong, nonatomic) IBOutlet UILabel *answer;
- (IBAction)shake:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *question;
@property (nonatomic)EightBallModel * eightball;

@end

@implementation lab2ViewController

-(void)predict:(UIButton *)sender;

{
    self.eightball = [[EightBallModel alloc]init];
    
    int index = arc4random()%[self.eightball.responseArray count];
    self.answer.text = self.eightball.responseArray[index];
    [self.answer setAlpha:0.0];
    [UIView animateWithDuration:1.0 animations:^(void){
        [self.answer setAlpha:1.0];
    }];
    NSMutableString * filename = [NSString stringWithFormat:@"circle%d",arc4random()%6+1];
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@".png"];
    UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
    [self.ball setImage:img];
    
    /*
     UIImage * myImage= [UIImage imageNamed:filename];
     
     //CGRect frame = CGRectMake(100, 100, 200,200);
     [self.ball setImage:myImage];
     self.ball.frame = CGRectMake(200, 200,
     200, 200);
     */
}

- (IBAction)go:(id)sender {
    [self predict:sender];
}
- (IBAction)shake:(UIButton *)sender {
    
    [self predict:sender];
}

-(BOOL)textFieldShouldReturn:(UITextField *)question{
    [question resignFirstResponder];
    [self predict:question];
    return YES;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.question.text = @"Ask whatever you like.";
    self.question.clearsOnBeginEditing = YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
