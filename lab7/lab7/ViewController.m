//
//  ViewController.m
//  lab7
//
//  Created by Jason Zhou on 13-10-13.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface ViewController ()
@property (retain, nonatomic) IBOutlet UILabel *english;

- (IBAction)change:(UIButton *)sender;
@property (strong,nonatomic) NSMutableArray *array;
@property (retain, nonatomic) IBOutlet UILabel *chinese;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.array = [NSMutableArray arrayWithObjects:@"For he to-day that sheds his blood with me.Shall be my brother. (Henry V)",@"Out, out, brief candle, life is but a walking shadow. (Macbeth)",@"It is the east, and Juliet is the sun. (Romeo and Juliet)", @"The rest is silence. (Hamlet)",nil];
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc]init];
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"Some random text that you want to be spoken"];
    [utterance setRate:1.1f];
    [synthesizer speakUtterance:utterance];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_english release];
    [_chinese release];
    [super dealloc];
}
- (IBAction)change:(UIButton *)sender {
    NSString *tmp = [self.array objectAtIndex:arc4random()%4];
    self.english.text = tmp;
    self.chinese.text = NSLocalizedString(tmp, @"shakespeare");
    
}
@end
