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

#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

#define AVERAGELINEANIMATIONDURATION 1.0

@interface SingleMetricViewController () {
    int previousStepperValue;
    int totalNumber;
    CGRect aveStartingPos;
    BOOL averageHidden;
}

@property (strong, nonatomic) PFLogInViewController *parseLogInViewController;

@property (strong, nonatomic) MDRadialProgressView *averageRadialView;
@property (strong, nonatomic) MDRadialProgressView *forecastRadialView;

@property (strong, nonatomic) NSNumber *average;
@property (strong, nonatomic) NSNumber *forecast;


@end

@implementation SingleMetricViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *string = [NSString stringWithFormat:@"%@ %@", self.graphName, self.graphDefinition];
    NSMutableAttributedString *definitionString = [[NSMutableAttributedString alloc] initWithString:string];
    [definitionString addAttribute:NSForegroundColorAttributeName value:self.graphColor range:NSMakeRange(0, self.graphName.length)];
    [definitionString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:130.0/255.0 green:130.0/255.0 blue:130.0/255.0 alpha:1.0] range:NSMakeRange(self.graphName.length, string.length - self.graphName.length)];
    [definitionString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Museo-500" size:18] range:NSMakeRange(0, string.length)];
    
    [self.definitionLabel setAttributedText:definitionString];
    
    
    previousStepperValue = self.graphObjectIncrement.value;
    totalNumber = 0;
    
    ;    self.ArrayOfDates = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    
    [self.ArrayOfDates addObject:@""];
    for (int i=1; i < self.metricDaysArray.count; i++) {
        NSString *day = [dateFormatter stringFromDate:[self.metricDaysArray objectAtIndex:i]];
        [self.ArrayOfDates addObject:[day substringToIndex:3]];
    }
    [self.ArrayOfDates addObject:@""];
    
    
    //self.ArrayOfDates = [NSMutableArray arrayWithObjects:@"", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    //self.ArrayOfDates = [NSArray arrayWithObjects:@"",  @"", @"",  @"", @"",  @"", @"",  @"", @"", @"", @"", @"", @"",  nil];
    
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
    
    //set label colors
    [self.avgButton setTitleColor:self.graphColor forState:UIControlStateNormal];
    [self.forecastButton setTitleColor:self.graphColor forState:UIControlStateNormal];
    
    self.myGraph.backgroundColor = self.graphColor;
    
    
    
    UIColor *topColor = [UIColor colorWithRed:1 green:0.92 blue:0.56 alpha:1];
    UIColor *bottomColor = [UIColor colorWithRed:0.18 green:0.18 blue:0.18 alpha:1];
    /*
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = cell.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor whiteColor]CGColor], (id)[[UIColor redColor]CGColor], nil];
    [cell.layer addSublayer:gradient];
    */
    
    
    //setup average and forecast
    
    UIFont *labelFont = [UIFont fontWithName:@"Montserrat-Regular" size:23];
    
    [self.averageLabel setFont:labelFont];
    [self.forecastLabel setFont:labelFont];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:40];
    
    CGRect radialAverageRect;
    
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.sliceDividerHidden = YES;
    theme.completedColor = self.graphColor;
    theme.incompletedColor = [self.graphColor colorWithAlphaComponent:.5];
    theme.labelColor = [UIColor clearColor];

    self.average = [self.ArrayOfValues valueForKeyPath:@"@avg.self"];
    [self.avgButton setTitle:[formatter stringFromNumber:self.average] forState:UIControlStateNormal];
    [self.avgButton.titleLabel setFont:font];
    
    radialAverageRect = CGRectMake(50, 440, 100, 100);
    self.averageRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.averageRadialView.progressTotal = 500;
    self.averageRadialView.progressCounter = 0;
    [self.view addSubview:self.averageRadialView];
    
    
    self.forecast = [NSNumber numberWithDouble:4.8];
    [self.forecastButton setTitle:[formatter stringFromNumber:self.forecast] forState:UIControlStateNormal];
    [self.forecastButton.titleLabel setFont:font];
    
    radialAverageRect = CGRectMake(170, 440, 100, 100);
    self.forecastRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.forecastRadialView.progressTotal = 500;
    self.forecastRadialView.progressCounter = 0;
    [self.view addSubview:self.forecastRadialView];
    
    [self.view bringSubviewToFront:self.avgButton];
    [self.view bringSubviewToFront:self.forecastButton];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    aveStartingPos = self.averageLineView.frame;
    //[self.averageLineView setHidden:YES];
    averageHidden = YES;
    [self showAverageLine];
    
    self.averageRadialView.progressCounter = 0;
    [self radialView:self.averageRadialView incrementAverage:self.average];
    
    self.forecastRadialView.progressCounter = 0;
    [self radialView:self.forecastRadialView incrementAverage:self.forecast];
    
}



#pragma mark - Graph Actions

- (IBAction)averagePressed:(id)sender {
    
    if (averageHidden) {
        [self showAverageLine];
    }
    else {
        [self hideAverageLine];
    }
    
}

- (IBAction)forecastPressed:(id)sender {
    [self.singleMetricTableViewController showAssesment];
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
    
    [self.myGraph reloadGraph];
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
    
    averageHidden = NO;
    //self.averageLineView.frame = aveStartingPos;
    
    //[self.averageLineView setHidden:NO];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView animateWithDuration:AVERAGELINEANIMATIONDURATION animations:^{
            CGFloat avgLineYVal = 358.75 - ([self.average floatValue] * 48.75) - 15.0;
            CGRect avgLineRect = CGRectMake(0, avgLineYVal, self.averageLineView.frame.size.width, self.averageLineView.frame.size.height);
            self.averageLineView.frame = avgLineRect;
    } completion:^(BOOL finished) {
        
    }];
        /*
    [UIView transitionWithView:self.view duration:AVERAGELINEANIMATIONDURATION options:UIViewAnimationTransitionNone animations:^{
        CGFloat avgLineYVal = 273.75 - ([self.average floatValue] * 48.75) - 15.0;
        CGRect avgLineRect = CGRectMake(0, avgLineYVal, self.averageLineView.frame.size.width, self.averageLineView.frame.size.height);
        self.averageLineView.frame = avgLineRect;
    } completion:^(BOOL finished) {
        
    }];
         */
    
}

- (void) hideAverageLine {
    
    averageHidden = YES;
    /*
    CGFloat avgLineYVal = 273.75 - ([self.average floatValue] * 48.75) - 15.0;
    CGRect avgLineRect = CGRectMake(0, avgLineYVal, self.averageLineView.frame.size.width, self.averageLineView.frame.size.height);
    self.averageLineView.frame = avgLineRect;
     */
    
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView animateWithDuration:AVERAGELINEANIMATIONDURATION animations:^{
        self.averageLineView.frame = aveStartingPos;
    } completion:^(BOOL finished) {
        //[self.averageLineView setHidden:YES];
    }];
    
}

- (void) radialView:(MDRadialProgressView *) radialView incrementAverage:(NSNumber *) average{
    
    if (radialView.progressCounter < [average floatValue] * 100) {
        radialView.progressCounter = radialView.progressCounter + 5;
        if (radialView.progressCounter >= [average floatValue] * 100) {
            radialView.progressCounter = [average floatValue] * 100;
        }
        else {
            double delayInSeconds = .02;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //code to be executed on the main queue after delay
                [self radialView:radialView incrementAverage:average];
            });
        }
    }
    
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
    return 0;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.ArrayOfDates objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    
}



@end
