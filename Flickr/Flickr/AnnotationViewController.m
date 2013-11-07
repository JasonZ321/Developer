//
//  AnnotationViewController.m
//  Flickr
//
//  Created by Jason Zhou on 13-11-6.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "AnnotationViewController.h"
#import "MapViewController.h"
@interface AnnotationViewController ()

@end

@implementation AnnotationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = self.annotation.title;
    NSString *tmp = @"taken at ";
    self.addressLabel.text = [tmp stringByAppendingString:self.annotation.address];
    NSURL *url = [NSURL URLWithString:self.annotation.bigImage];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
   
    self.fullscreenImg.contentSize = img.size;
    
    self.fullscreenImg.maximumZoomScale = 2.0;
    self.fullscreenImg.minimumZoomScale = 0.5;
    
    [self.fullscreenImg addSubview:imgView];
    
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
