//
//  DailySpaceCell.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWRadioButtons.h"
#import "DailySpaceTableViewController.h"
#import "TDRatingView.h"

@interface DailySpaceCell : UITableViewCell <TDRatingViewDelegate>

@property (strong, nonatomic) NSString *graphName;
@property (strong, nonatomic) UIColor *graphColor;
@property (strong, nonatomic) CWRadioButtons *buttons;
@property (strong, nonatomic) TDRatingView *ratingView;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UIButton *assessmentButton;

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;
@property (strong, nonatomic) IBOutlet UIButton *button4;
@property (strong, nonatomic) IBOutlet UIButton *button5;




- (void) setCellName:(NSString *) name;
- (void) setCellColor:(UIColor *) cellColor;
- (void) setTableViewController:(DailySpaceTableViewController *)tableViewController;


@end
