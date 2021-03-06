//
//  DailySpaceTableViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWRadioButtons.h"
#import "RMStepsController.h"
#import "CalendarViewController.h"

@interface DailySpaceTableViewController : UITableViewController <UIGestureRecognizerDelegate, CalendarViewControllerDelegate, CWRadioButtonsDelegate, RMStepsControllerDelegate>



- (IBAction)savePressed:(id)sender;
- (IBAction)menuPressed:(id)sender;
- (IBAction)assessmentPressed:(id)sender;
- (IBAction)calendarPressed:(id)sender;

- (void)buttonSelected:(UIButton *)button;



@end
