//
//  MetricsTableViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface MetricsTableViewController : UITableViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (strong, nonatomic) NSMutableArray *sleepArray;
@property (strong, nonatomic) NSMutableArray *presenceArray;
@property (strong, nonatomic) NSMutableArray *activityArray;
@property (strong, nonatomic) NSMutableArray *creativityArray;
@property (strong, nonatomic) NSMutableArray *eatingArray;
@property (strong, nonatomic) NSMutableArray *metricDaysArray;

@property (strong, nonatomic) NSMutableArray *ArrayOfDates;


- (IBAction)menuPressed:(id)sender;

- (IBAction)otherValueButtonPressed:(id)sender;

- (IBAction)chartMyDayPressed:(id)sender;



@end

