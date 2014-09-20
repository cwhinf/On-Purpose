//
//  AppDelegate.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "PaperFoldNavigationController.h"
#import "MenuViewController.h"
#import "MainTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;
@property (strong, nonatomic) MenuViewController *menuViewController;

@property (strong, nonatomic) MainTabBarController *mainTabBarController;

@end
