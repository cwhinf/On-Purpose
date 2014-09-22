//
//  ChartPopViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/19/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartPopViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *chartLabel;

@property (strong, nonatomic) IBOutlet UIButton *bottomButton;

@property (strong, nonatomic) IBOutlet UIView *containerView;

- (IBAction)closePressed:(id)sender;
- (IBAction)bottomButtonPressed:(id)sender;

- (void)showAssessment;


@end
