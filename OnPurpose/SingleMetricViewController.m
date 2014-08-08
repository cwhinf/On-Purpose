//
//  SingleMetricViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/4/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Parse/Parse.h>

#import "SingleMetricViewController.h"
#import "Constants.h"

#define AVERAGELINEANIMATIONDURATION 1.0

@interface SingleMetricViewController () {
    int previousStepperValue;
    int totalNumber;
    CGRect aveStartingPos;
}

@property (strong, nonatomic) PFLogInViewController *parseLogInViewController;

@property (strong, nonatomic) NSNumber *average;


@end

@implementation SingleMetricViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    previousStepperValue = self.graphObjectIncrement.value;
    totalNumber = 0;
    
    
    //self.ArrayOfDates = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    self.ArrayOfDates = [NSArray arrayWithObjects:@"",  @"", @"",  @"", @"",  @"", @"",  @"", @"", @"", @"", @"", @"",  nil];
    
    /* This is commented out because the graph is created in the interface with this sample app. However, the code remains as an example for creating the graph using code.
     BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, 320, 250)];
     myGraph.delegate = self;
     [self.view addSubview:myGraph]; */
    
    NSInteger graphMin = 1;
    NSInteger graphMax = 5;
    
    // Customization of the graph
    self.myGraph.colorTop = self.graphColor;
    self.myGraph.colorBottom = self.graphColor; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.myGraph.colorLine = [UIColor whiteColor];
    self.myGraph.colorXaxisLabel = [UIColor whiteColor];
    self.myGraph.widthLine = 3.0;
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableBezierCurve = YES;
    self.myGraph.min = graphMin;
    self.myGraph.max = graphMax;
    
    // The labels to report the values of the graph when the user touches it
    [self.labelValues setTextColor:self.graphColor];
    
    //set navController color and font
    self.navigationController.navigationBar.tintColor = self.graphColor;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:self.graphColor forKey:@"NSColor"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    NSDictionary *backButtonAttricbutes = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Helvetica Neue" size:20],
                                           NSFontAttributeName,
                                           nil];
    [self.backButton setTitleTextAttributes:backButtonAttricbutes forState:UIControlStateNormal];
    
    //set label colors
    [self.avgButton setTitleColor:self.graphColor forState:UIControlStateNormal];
    [self.predictionLabel setTextColor:self.graphColor];
    
    self.myGraph.backgroundColor = self.graphColor;
    
    //set label text
    [self.labelValues setText:self.graphName];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    
    self.average = [self.ArrayOfValues valueForKeyPath:@"@avg.self"];
    [self.avgButton setTitle:[formatter stringFromNumber:self.average] forState:UIControlStateNormal];
    
    
    UIColor *topColor = [UIColor colorWithRed:1 green:0.92 blue:0.56 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1];
    /*
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor redColor]CGColor], nil];
    [cell.layer addSublayer:gradient];
    */
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    
    aveStartingPos = self.averageLineView.frame;
    [self.averageLineView setHidden:YES];
    
    [self showAverageLine];
    
}

#pragma mark - Graph Actions

- (IBAction)averagePressed:(id)sender {
    
    if (self.averageLineView.frame.origin.y == aveStartingPos.origin.y) {
        [self showAverageLine];
    }
    else {
        [self hideAverageLine];
    }
    
}

- (IBAction)refresh:(id)sender {
    /*
     [self.ArrayOfValues removeAllObjects];
     [self.ArrayOfDates removeAllObjects];
     
     for (int i = 0; i < self.graphObjectIncrement.value; i++) {
     [self.ArrayOfValues addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]]; // Random values for the graph
     [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%@",[NSNumber numberWithInt:2000 + i]]]; // Dates for the X-Axis of the graph
     
     totalNumber = totalNumber + [[self.ArrayOfValues objectAtIndex:i] intValue]; // All of the values added together
     }
     */
    UIColor *color = self.graphColor;
    self.myGraph.colorTop = color;
    self.myGraph.colorBottom = color;
    self.myGraph.backgroundColor = color;
    self.view.tintColor = color;
    self.labelValues.textColor = color;
    self.navigationController.navigationBar.tintColor = color;
    
    [self.myGraph reloadGraph];
}

- (IBAction)backPressed:(id)sender {
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0] forKey:@"NSColor"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}
/*
- (IBAction)addOrRemoveLineFromGraph:(id)sender {
    if (self.graphObjectIncrement.value > previousStepperValue) {
        // Add line
        [self.ArrayOfValues addObject:[NSNumber numberWithInteger:(arc4random() % 70000)]];
        [self.ArrayOfDates addObject:[NSString stringWithFormat:@"%i", (int)[[self.ArrayOfDates lastObject] integerValue]+1]];
        [self.myGraph reloadGraph];
    } else if (self.graphObjectIncrement.value < previousStepperValue) {
        // Remove line
        [self.ArrayOfValues removeObjectAtIndex:0];
        [self.ArrayOfDates removeObjectAtIndex:0];
        [self.myGraph reloadGraph];
    }
    
    previousStepperValue = self.graphObjectIncrement.value;
}*/

- (void) showAverageLine {
    
    [self.averageLineView setHidden:NO];
    [UIView transitionWithView:self.view duration:AVERAGELINEANIMATIONDURATION options:UIViewAnimationTransitionNone animations:^{
        CGFloat avgLineYVal = 273.75 - ([self.average floatValue] * 48.75) - 15.0;
        CGRect avgLineRect = CGRectMake(0, avgLineYVal, self.averageLineView.frame.size.width, self.averageLineView.frame.size.height);
        self.averageLineView.frame = avgLineRect;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void) hideAverageLine {
    
    [UIView transitionWithView:self.view duration:AVERAGELINEANIMATIONDURATION options:UIViewAnimationTransitionNone animations:^{
        self.averageLineView.frame = aveStartingPos;
    } completion:^(BOOL finished) {
        [self.averageLineView setHidden:YES];
    }];
    
}



- (IBAction)displayStatistics:(id)sender {
    [self performSegueWithIdentifier:@"showStats" sender:self];
}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.ArrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.ArrayOfValues objectAtIndex:index] floatValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 1;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.ArrayOfDates objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.labelValues.alpha = 0.0;
        self.labelDates.alpha = 0.0;
    } completion:^(BOOL finished){
        
        
        [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.labelValues.alpha = 1.0;
            self.labelDates.alpha = 1.0;
        } completion:nil];
    }];
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    
}



@end
