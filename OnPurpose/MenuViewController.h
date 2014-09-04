//
//  MenuViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/11/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaperFoldNavigationController.h"


@interface MenuViewController : UIViewController

@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UILabel *label3;







@end
