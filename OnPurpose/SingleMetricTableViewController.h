//
//  SingleMetricTableViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/5/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "BEMSimpleLineGraphView.h"


@interface SingleMetricTableViewController : UITableViewController <BEMSimpleLineGraphDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
{
    int previousStepperValue;
    int totalNumber;
}


@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *myGraph;

@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;
@property (strong, nonatomic) NSMutableArray *metricDaysArray;
@property (strong, nonatomic) UIColor *graphColor;
@property (strong, nonatomic) NSString *graphName;

@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;

@property (strong, nonatomic) IBOutlet UILabel *avgLabel;
@property (strong, nonatomic) IBOutlet UILabel *predictionLabel;




@property (strong, nonatomic) IBOutlet UIBarButtonItem *backButton;





- (IBAction)refresh:(id)sender;
- (IBAction)backPressed:(id)sender;

- (IBAction)addOrRemoveLineFromGraph:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *graphColorChoice;
@property (weak, nonatomic) IBOutlet UIStepper *graphObjectIncrement;


@end
