//
//  GameResultViewController.m
//  Matchismo
//
//  Created by Jason Zhou on 13-12-10.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "GameResultViewController.h"

@interface GameResultViewController ()

@end

@implementation GameResultViewController
- (void)setUp
{
    
}
- (void)awakeFromNib
{
    [self setUp];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    [self setUp];
    return self;
}
- (void)updateUI
{
    NSString *displayText = @"";
    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self updateUI];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
