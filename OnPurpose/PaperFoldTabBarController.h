//
//  PaperFoldTabBarController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/11/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperFoldNavigationController.h"
#import "RNFrostedSidebar.h"


@interface PaperFoldTabBarController : UITabBarController <RNFrostedSidebarDelegate>

@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;

-(void) showMenu;


-(void) hideMenu;


@end
