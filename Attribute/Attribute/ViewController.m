//
//  ViewController.m
//  Attribute
//
//  Created by Jason Zhou on 13-12-8.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIStepper *selectedWordStepper;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UILabel *selectedWordLabel;

@end

@implementation ViewController
- (void)addLabelAttributes:(NSDictionary *)attributes range:(NSRange)range
{
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.label.attributedText mutableCopy];
       
        [mat addAttributes:attributes range:range];
        self.label.attributedText = mat;
         NSLog(@"%@",mat);
    }
}
- (IBAction)changeColor:(UIButton *)sender {
    [self addSelectedWordAttributes:@{ NSForegroundColorAttributeName : sender.backgroundColor}];
}
- (void)addSelectedWordAttributes:(NSDictionary *)attributes
{
    NSRange range = [[self.label.attributedText string] rangeOfString:[self selectedWord]];
    [self addLabelAttributes:attributes range:range];
}
- (IBAction)underline{
    [self addSelectedWordAttributes:@{ NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    
}



- (NSArray *)wordList
{
    NSArray *wordList = [[self.label.attributedText string] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([wordList count]) {
        return wordList;
    }else{
        return @[@""];
    }
}

- (NSString *)selectedWord
{
    return [self wordList][(int)self.selectedWordStepper.value];
}
- (IBAction)updateSelectedWord {
    self.selectedWordStepper.maximumValue = [[self wordList]count]-1;
    self.selectedWordLabel.text = [self selectedWord];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self updateSelectedWord];
}
@end
