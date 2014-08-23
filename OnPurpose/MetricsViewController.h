//
//  ViewController.h
//  SimpleLineGraph
//
//  Created by Bobo on 12/27/13. Updated by Sam Spencer on 1/11/14.
//  Copyright (c) 2013 Boris Emorine. All rights reserved.
//  Copyright (c) 2014 Sam Spencer.
//

#import <Parse/Parse.h>


#import "BEMSimpleLineGraphView.h"

@interface MetricsViewController : UIViewController <BEMSimpleLineGraphDelegate, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *sleepGraph;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *presenceGraph;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *activityGraph;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *creativityGraph;
@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *eatingGraph;

@property (strong, nonatomic) IBOutlet UILabel *sleepValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *presenceValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *activityValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *creativityValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *eatingValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *purposeValueLabel;

@property (strong, nonatomic) IBOutlet UIButton *sleepButton;
@property (strong, nonatomic) IBOutlet UIButton *presenceButton;
@property (strong, nonatomic) IBOutlet UIButton *activityButton;
@property (strong, nonatomic) IBOutlet UIButton *creativityButton;
@property (strong, nonatomic) IBOutlet UIButton *eatingButton;
@property (strong, nonatomic) IBOutlet UIButton *purposeButton;






@property (strong, nonatomic) NSMutableArray *sleepArray;
@property (strong, nonatomic) NSMutableArray *presenceArray;
@property (strong, nonatomic) NSMutableArray *activityArray;
@property (strong, nonatomic) NSMutableArray *creativityArray;
@property (strong, nonatomic) NSMutableArray *eatingArray;
@property (strong, nonatomic) NSMutableArray *metricDaysArray;


@property (strong, nonatomic) NSMutableArray *ArrayOfDates;

@property (strong, nonatomic) IBOutlet UILabel *labelValues;
@property (strong, nonatomic) IBOutlet UILabel *labelDates;

- (IBAction)menuPressed:(id)sender;

- (IBAction)refresh:(id)sender;
- (IBAction)addOrRemoveLineFromGraph:(id)sender;
- (IBAction)metricButtonPressed:(id)sender;





@property (weak, nonatomic) IBOutlet UISegmentedControl *graphColorChoice;
@property (weak, nonatomic) IBOutlet UIStepper *graphObjectIncrement;

- (IBAction)displayStatistics:(id)sender;

@end