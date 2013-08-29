//
//  PostFixViewController.h
//  PostFix
//
//  Created by Jason Zhou on 13-8-27.
//  Copyright (c) 2013年 Jiasheng Zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NumStack.h"
@interface PostFixViewController : UIViewController<StackDelegate>
@property (strong,nonatomic)NumStack * stack;
@end
