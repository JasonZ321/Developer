//
//  AttributerViewController.m
//  Attributer
//
//  Created by Jason Zhou on 14-3-31.
//  Copyright (c) 2014年 Jiasheng Zhou. All rights reserved.
//

#import "AttributerViewController.h"

@interface AttributerViewController ()
@property (weak, nonatomic) IBOutlet UITextView *body;
@property (weak, nonatomic) IBOutlet UILabel *headline;

@property (weak, nonatomic) IBOutlet UIButton *outlineButton;

@end

@implementation AttributerViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:self.outlineButton.currentTitle];
    [title setAttributes:@{NSStrokeWidthAttributeName: @3,
                           NSStrokeColorAttributeName: self.outlineButton.tintColor}
                   range:NSMakeRange(0,[title length])];
    [self.outlineButton setAttributedTitle:title forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self usePreferredFonts];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:) name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
}
- (void)preferredFontsChanged:(NSNotification *)notification
{
    [self usePreferredFonts];
}
- (void)usePreferredFonts
{
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
}

- (IBAction)changeBodySelectionColorToMatchBackgroundOfButton:(UIButton *)sender;
{
    [self.body.textStorage addAttribute: NSForegroundColorAttributeName value:sender.backgroundColor range:self.body.selectedRange];
}
- (IBAction)outlineBodySelection:(UIButton *)sender {
    [self.body.textStorage addAttributes:@{ NSStrokeWidthAttributeName : @-3,
                                              NSStrokeColorAttributeName : [UIColor blackColor]} range:self.body.selectedRange];
}
- (IBAction)unoutlineBodySelection:(UIButton *)sender {
    
}






@end
