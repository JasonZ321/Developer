//
//  ImageViewController.m
//  scrollview
//
//  Created by Jason Zhou on 13-9-12.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (strong,nonatomic) UIImageView *imageView;
@end

@implementation ImageViewController
- (UIImageView*) imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _imageView;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [self resetImage];
}
- (void)resetImage
{
    if(self.scrollview){
        self.scrollview.contentSize = CGSizeZero;
        self.imageView.image = nil;
        NSData* data = [[NSData alloc]initWithContentsOfURL:self.imageURL];
        UIImage* image = [[UIImage alloc]initWithData:data];
        
        if(image){
            self.scrollview.zoomScale = 1.0;
            self.scrollview.contentSize = image.size;
            self.imageView.image = image;
            self.imageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        }   
    }
}
- (UIView *) viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollview addSubview:self.imageView];
    [self resetImage];
    self.scrollview.maximumZoomScale = 5.0;
    self.scrollview.minimumZoomScale = 0.2;
    self.scrollview.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
