//
//  PaperFoldTabBarController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/11/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperFoldNavigationController.h"

@interface PaperFoldTabBarController : UITabBarController

@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;

@end
