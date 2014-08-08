//
//  ViewController.m
//  SimpleLineGraph
//
//  Created by Bobo on 12/27/13. Updated by Sam Spencer on 1/11/14.
//  Copyright (c) 2013 Boris Emorine. All rights reserved.
//  Copyright (c) 2014 Sam Spencer.
//

#import <Parse/Parse.h>

#import "MetricsViewController.h"
#import "SingleMetricViewController.h"
#import "SingleMetricTableViewController.h"
#import "Constants.h"


@interface MetricsViewController () {
    int previousStepperValue;
    int totalNumber;
}

@property (strong, nonatomic) PFLogInViewController *parseLogInViewController;

@end

@implementation MetricsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    
    self.sleepArray = [[NSMutableArray alloc] init];
    self.presenceArray = [[NSMutableArray alloc] init];
    self.activityArray = [[NSMutableArray alloc] init];
    self.creativityArray = [[NSMutableArray alloc] init];
    self.eatingArray = [[NSMutableArray alloc] init];
    self.metricDaysArray = [[NSMutableArray alloc] init];
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    previousStepperValue = self.graphObjectIncrement.value;
    totalNumber = 0;
    
    /*
    for (int i = 0; i < 9; i++) {
        //[self.sleepArray addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]]; // Random values for the graph
        [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:2000 + i]]]; // Dates for the X-Axis of the graph
        
        //totalNumber = totalNumber + [[self.sleepArray objectAtIndex:i] intValue]; // All of the values added together
    }*/
    self.ArrayOfDates = [NSArray arrayWithObjects:@"",  @"", @"",  @"", @"",  @"", @"",  @"", @"", @"", @"", @"", @"",  nil];
    
    /* This is commented out because the graph is created in the interface with this sample app. However, the code remains as an example for creating the graph using code.
     BEMSimpleLineGraphView *sleepGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, 320, 250)];
     sleepGraph.delegate = self;
     [self.view addSubview:sleepGraph]; */
    
    NSInteger graphMin = 2;
    NSInteger graphMax = 5;
    
    // Customization of the graph
    self.sleepGraph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.sleepGraph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.sleepGraph.colorLine = [UIColor whiteColor];
    self.sleepGraph.colorXaxisLabel = [UIColor whiteColor];
    self.sleepGraph.widthLine = 3.0;
    self.sleepGraph.enableTouchReport = YES;
    self.sleepGraph.enablePopUpReport = YES;
    self.sleepGraph.enableBezierCurve = YES;
    self.sleepGraph.min = graphMin;
    self.sleepGraph.max = graphMax;
    
    self.presenceGraph.colorTop = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.presenceGraph.colorBottom = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.presenceGraph.colorLine = [UIColor whiteColor];
    self.presenceGraph.colorXaxisLabel = [UIColor whiteColor];
    self.presenceGraph.widthLine = 3.0;
    self.presenceGraph.enableTouchReport = YES;
    self.presenceGraph.enablePopUpReport = YES;
    self.presenceGraph.enableBezierCurve = YES;
    self.presenceGraph.min = graphMin;
    self.presenceGraph.max = graphMax;
    
    self.activityGraph.colorTop = [UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0];
    self.activityGraph.colorBottom = [UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.activityGraph.colorLine = [UIColor whiteColor];
    self.activityGraph.colorXaxisLabel = [UIColor whiteColor];
    self.activityGraph.widthLine = 3.0;
    self.activityGraph.enableTouchReport = YES;
    self.activityGraph.enablePopUpReport = YES;
    self.activityGraph.enableBezierCurve = YES;
    self.activityGraph.min = graphMin;
    self.activityGraph.max = graphMax;
    
    self.creativityGraph.colorTop = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.creativityGraph.colorBottom = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.creativityGraph.colorLine = [UIColor whiteColor];
    self.creativityGraph.colorXaxisLabel = [UIColor whiteColor];
    self.creativityGraph.widthLine = 3.0;
    self.creativityGraph.enableTouchReport = YES;
    self.creativityGraph.enablePopUpReport = YES;
    self.creativityGraph.enableBezierCurve = YES;
    self.creativityGraph.min = graphMin;
    self.creativityGraph.max = graphMax;
    
    self.eatingGraph.colorTop = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.eatingGraph.colorBottom = [UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.eatingGraph.colorLine = [UIColor whiteColor];
    self.eatingGraph.colorXaxisLabel = [UIColor whiteColor];
    self.eatingGraph.widthLine = 3.0;
    self.eatingGraph.enableTouchReport = YES;
    self.eatingGraph.enablePopUpReport = YES;
    self.eatingGraph.enableBezierCurve = YES;
    self.eatingGraph.min = graphMin;
    self.eatingGraph.max = graphMax;
    
    
    // The labels to report the values of the graph when the user touches it
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.sleepGraph calculatePointValueSum] intValue]];
    self.labelDates.text = @"between 2000 and 2010";
    
    
    if ([PFUser currentUser]) {
        PFQuery *metricsQuery = [PFQuery queryWithClassName:metricsClassKey];
        [metricsQuery whereKey:metricsUserKey equalTo:[PFUser currentUser]];
        [metricsQuery orderByAscending:metricsDayKey];
        [metricsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            for (PFObject *object in objects) {
                [self.sleepArray addObject:(NSNumber *)[object objectForKey:metricsSleepKey]];
                [self.presenceArray addObject:(NSNumber *)[object objectForKey:metricsPresenceKey]];
                [self.activityArray addObject:(NSNumber *)[object objectForKey:metricsActivityKey]];
                [self.creativityArray addObject:(NSNumber *)[object objectForKey:metricsCreativityKey]];
                [self.eatingArray addObject:(NSNumber *)[object objectForKey:metricsEatingKey]];
                [self.metricDaysArray addObject:(NSDate *)[object objectForKey:metricsDayKey]];
            }
            totalNumber = self.sleepArray.count;
            [self refresh:nil];
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [self checkForUser];
    if (!self.sleepArray) {
        PFQuery *metricsQuery = [PFQuery queryWithClassName:metricsClassKey];
        [metricsQuery whereKey:metricsUserKey equalTo:[PFUser currentUser]];
        [metricsQuery orderByDescending:metricsCreatedAtKey];
        [metricsQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            for (PFObject *object in objects) {
                [self.sleepArray addObject:(NSNumber *)[object objectForKey:metricsSleepKey]];
                [self.presenceArray addObject:(NSNumber *)[object objectForKey:metricsPresenceKey]];
                [self.activityArray addObject:(NSNumber *)[object objectForKey:metricsActivityKey]];
                [self.creativityArray addObject:(NSNumber *)[object objectForKey:metricsCreativityKey]];
                [self.eatingArray addObject:(NSNumber *)[object objectForKey:metricsEatingKey]];
            }
            totalNumber = self.sleepArray.count;
            [self refresh:nil];
        }];
    }
    [self refresh:nil];
    
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0],
                                                           NSForegroundColorAttributeName,
                                                           [UIFont fontWithName:@"Helvetica Neune Light" size:27],
                                                           NSFontAttributeName,
                                                           nil]];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (bool) checkForUser {
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        self.parseLogInViewController = [[PFLogInViewController alloc] init];
        self.parseLogInViewController.delegate = self;
        self.parseLogInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton;
        
        PFSignUpViewController *parseSignUpViewController = [[PFSignUpViewController alloc] init];
        parseSignUpViewController.delegate = self;
        parseSignUpViewController.fields = PFSignUpFieldsUsernameAndPassword| PFSignUpFieldsDismissButton | PFSignUpFieldsSignUpButton;
        self.parseLogInViewController.signUpController = parseSignUpViewController;
        
        
        // Present the log in view controller
        [self presentViewController:self.parseLogInViewController animated:YES completion:NULL];
        
        return FALSE;
    }
    else {
        return TRUE;
    }
}

- (void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self.parseLogInViewController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Graph Actions

- (IBAction)refresh:(id)sender {
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];

    NSNumber *average = [self.sleepArray valueForKeyPath:@"@avg.self"];
    [self.sleepValueLabel setText:[formatter stringFromNumber:average]];
    
    average = [self.presenceArray valueForKeyPath:@"@avg.self"];
    [self.presenceValueLabel setText:[formatter stringFromNumber:average]];
    
    average = [self.activityArray valueForKeyPath:@"@avg.self"];
    [self.activityValueLabel setText:[formatter stringFromNumber:average]];
    
    average = [self.creativityArray valueForKeyPath:@"@avg.self"];
    [self.creativityValueLabel setText:[formatter stringFromNumber:average]];
    
    average = [self.eatingArray valueForKeyPath:@"@avg.self"];
    [self.eatingValueLabel setText:[formatter stringFromNumber:average]];

    [self.sleepGraph reloadGraph];
    [self.presenceGraph reloadGraph];
    [self.activityGraph reloadGraph];
    [self.creativityGraph reloadGraph];
    [self.eatingGraph reloadGraph];
    
}

- (IBAction)addOrRemoveLineFromGraph:(id)sender {
    if (self.graphObjectIncrement.value > previousStepperValue) {
        // Add line
        [self.sleepArray addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]];
        [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%i", (int)[[self.ArrayOfDates lastObject] integerValue]+1]];
        [self.sleepGraph reloadGraph];
    } else if (self.graphObjectIncrement.value < previousStepperValue) {
        // Remove line
        [self.sleepArray removeObjectAtIndex:0];
        [self.ArrayOfDates removeObjectAtIndex:0];
        [self.sleepGraph reloadGraph];
    }
    
    previousStepperValue = self.graphObjectIncrement.value;
}

- (IBAction)displayStatistics:(id)sender {
    [self performSegueWithIdentifier:@"showStats" sender:self];
}

#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    if ([graph isEqual:self.sleepGraph]) {
        return (int)[self.sleepArray count];
    }
    else if ([graph isEqual:self.presenceGraph]) {
        return (int)[self.presenceArray count];
    }
    else if ([graph isEqual:self.activityGraph]) {
        return (int)[self.activityArray count];
    }
    else if ([graph isEqual:self.creativityGraph]) {
        return (int)[self.creativityArray count];
    }
    else if ([graph isEqual:self.eatingGraph]) {
        return (int)[self.eatingArray count];
    }
    else return 0;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    if ([graph isEqual:self.sleepGraph]) {
        return [[self.sleepArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:self.presenceGraph]) {
        return [[self.presenceArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:self.activityGraph]) {
        return [[self.activityArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:self.creativityGraph]) {
        return [[self.creativityArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:self.eatingGraph]) {
        return [[self.eatingArray objectAtIndex:index] floatValue];
    }
    else return 0;
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.ArrayOfDates objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    self.labelValues.text = [NSString stringWithFormat:@"%@", [self.sleepArray objectAtIndex:index]];
    self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.ArrayOfDates objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.labelValues.alpha = 0.0;
        self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished){
        
        self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.sleepGraph calculatePointValueSum] intValue]];
        self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.labelValues.alpha = 1.0;
            self.labelDates.alpha = 1.0;
        } completion:nil];
    }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.sleepGraph calculatePointValueSum] intValue]];
    self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [super prepareForSegue:segue sender:sender];

    if ([segue.identifier isEqualToString:@"showSleepMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        singleMetricTableViewController.ArrayOfValues = self.sleepArray;
        singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
        singleMetricTableViewController.graphColor = self.sleepGraph.backgroundColor;
        singleMetricTableViewController.graphName = @"Sleep";
    }
    else if ([segue.identifier isEqualToString:@"showPresenceMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        singleMetricTableViewController.ArrayOfValues = self.presenceArray;
        singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
        singleMetricTableViewController.graphColor = self.presenceGraph.backgroundColor;
        singleMetricTableViewController.graphName = @"Presence";
    }
    else if ([segue.identifier isEqualToString:@"showActivityMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        singleMetricTableViewController.ArrayOfValues = self.activityArray;
        singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
        singleMetricTableViewController.graphColor = self.activityGraph.backgroundColor;
        singleMetricTableViewController.graphName = @"Activity";
    }
    else if ([segue.identifier isEqualToString:@"showCreativityMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        singleMetricTableViewController.ArrayOfValues = self.creativityArray;
        singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
        singleMetricTableViewController.graphColor = self.creativityGraph.backgroundColor;
        singleMetricTableViewController.graphName = @"Creativity";
    }
    else if ([segue.identifier isEqualToString:@"showEatingMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        singleMetricTableViewController.ArrayOfValues = self.eatingArray;
        singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
        singleMetricTableViewController.graphColor = self.eatingGraph.backgroundColor;
        singleMetricTableViewController.graphName = @"Eating";
    }
}


@end







