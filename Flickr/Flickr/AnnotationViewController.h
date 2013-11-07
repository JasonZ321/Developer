//
//  AnnotationViewController.h
//  Flickr
//
//  Created by Jason Zhou on 13-11-6.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Annotation.h"
@interface AnnotationViewController : UIViewController
@property (nonatomic, strong) Annotation *annotation;
@property (strong, nonatomic) IBOutlet UIScrollView *fullscreenImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *addressLabel;

@end
