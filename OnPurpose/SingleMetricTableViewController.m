//
//  SingleMetricTableViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/5/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "SingleMetricTableViewController.h"
#import "SingleMetricViewController.h"
#import "SingleMetricDayCell.h"
#import "ScoreViewController.h"
#import "UIViewController+CWPopup.h"
#import "ForecastPopUpViewController.h"




#define HEADERHEIGHT 555
#define CELLHEIGHT 55
#define EXPANDEDHEIGHT 140
#define BLANKCELLHEIGHT 20
#define degreesToRadians(x)(x * M_PI / 180)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface SingleMetricTableViewController ()

@property (strong, nonatomic) SingleMetricViewController *singleMetricViewController;
@property (strong, nonatomic) NSMutableArray *cellHeight;
@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation SingleMetricTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = self.metric.graphName;
    
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    //previousStepperValue = self.graphObjectIncrement.value;
    totalNumber = 0;
    
    
    //self.ArrayOfDates = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    
    
    self.cellHeight = [[NSMutableArray alloc] initWithCapacity:self.ArrayOfValues.count];
    
    for (int i=0; i < self.ArrayOfValues.count; i++) {
        [self.cellHeight addObject:[NSNumber numberWithFloat:CELLHEIGHT]];
    }
    
    //set navController color and font
    self.navigationController.navigationBar.tintColor = self.metric.graphColor;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:self.metric.graphColor forKey:@"NSColor"];
    [attributes setObject:[UIFont mainFontWithSize:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    NSDictionary *backButtonAttricbutes = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont mainFontWithSize:20],
                                           NSFontAttributeName,
                                           nil];
    [self.backButton setTitleTextAttributes:backButtonAttricbutes forState:UIControlStateNormal];
    
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    self.tapRecognizer.numberOfTapsRequired = 1;
    self.tapRecognizer.delegate = self.tableView;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    else return self.ArrayOfValues.count + 1;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    if (section == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.singleMetricViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleMetricViewController"];
        self.singleMetricViewController.singleMetricTableViewController = self;
        self.singleMetricViewController.ArrayOfValues = self.ArrayOfValues;
        self.singleMetricViewController.metricDaysArray = self.metricDaysArray;
        self.singleMetricViewController.graphColor = self.metric.graphColor;
        self.singleMetricViewController.graphName = self.metric.graphName;
        self.singleMetricViewController.graphDefinition = self.metric.graphDefinition;
        
        return self.singleMetricViewController.view;;
    }
    else return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return HEADERHEIGHT;
    }
    else return 0.0f;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item < self.ArrayOfValues.count) {
        SingleMetricDayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dayCell" forIndexPath:indexPath];
        
        cell.clipsToBounds = YES;
        
        NSDate *date = [self.metricDaysArray objectAtIndex:indexPath.item];
        NSDateFormatter *prefixDateFormatter = [[NSDateFormatter alloc] init];
        [prefixDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        //[prefixDateFormatter setDateFormat:@"h:mm a EEEE MMMM d"];
        [prefixDateFormatter setDateFormat:@"MMMM d"];
        NSString *prefixDateString = [prefixDateFormatter stringFromDate:date];
        NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
        [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [monthDayFormatter setDateFormat:@"d"];
        int date_day = [[monthDayFormatter stringFromDate:date] intValue];
        NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
        NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
        NSString *suffix = [suffixes objectAtIndex:date_day];
        NSString *dateString = [prefixDateString stringByAppendingString:suffix];
        [cell.dayLabel setText:dateString];
        
        UIFont *font = [UIFont mainFontWithSize:28];
        [cell.valueLabel setFont:font];
        [cell.valueLabel setText:[NSString stringWithFormat:@"%@.0", (NSNumber *)[self.ArrayOfValues objectAtIndex:indexPath.item]]];
        [cell.valueLabel setTextColor:self.metric.graphColor];
        
        if ([(NSNumber *)[self.cellHeight objectAtIndex:indexPath.item] floatValue] == CELLHEIGHT) {
            cell.expandArrow.transform = CGAffineTransformMakeRotation(degreesToRadians(0.0f));
        }
        else {
            cell.expandArrow.transform = CGAffineTransformMakeRotation(degreesToRadians(180.0f));
        }
        
        return cell;
    }
    else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"blankCell" forIndexPath:indexPath];
        return cell;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item < self.ArrayOfValues.count) {
        return [(NSNumber *)[self.cellHeight objectAtIndex:indexPath.item] floatValue];
    }
    else return BLANKCELLHEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [CATransaction begin];
    
    [self.tableView beginUpdates];
    
    SingleMetricDayCell *cell = (SingleMetricDayCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.frame.size.height == CELLHEIGHT) {
        [self.cellHeight replaceObjectAtIndex:indexPath.item withObject:[NSNumber numberWithFloat:EXPANDEDHEIGHT]];
    }
    else {
        [self.cellHeight replaceObjectAtIndex:indexPath.item withObject:[NSNumber numberWithFloat:CELLHEIGHT]];
    }
    [UIView transitionWithView:cell.contentView duration:0.25 options:UIViewAnimationOptionTransitionNone animations:^{
        cell.expandArrow.transform = CGAffineTransformRotate(cell.expandArrow.transform, degreesToRadians(179.9999f));
    } completion:^(BOOL finished) {
    }];
    
    [CATransaction setCompletionBlock: ^{
    }];
    
    [tableView endUpdates];
    
    [CATransaction commit];
    
}



- (IBAction)backPressed:(id)sender {
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x23bd99);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:UIColorFromRGB(0x23bd99) forKey:@"NSColor"];
    [attributes setObject:[UIFont mainFontWithSize:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) showAssesment {
    if (self.metric.assessment) {
        [self performSegueWithIdentifier:@"showWhy" sender:self];
    }
}


- (void) showWhy {
    
    [self.navigationController.view addGestureRecognizer:self.tapRecognizer];
    
    
    UILabel *popUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 405.0, 260.0, 40.0)];
    [popUpLabel setTextColor:[UIColor whiteColor]];
    [popUpLabel setText:@"tap to close"];
    [popUpLabel setFont:[UIFont mainFontWithSize:20.0]];
    [popUpLabel setTextAlignment:NSTextAlignmentCenter];

    ForecastPopUpViewController *messageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"forecastPopUp"];
    messageViewController.view.frame = CGRectMake(30.0f, 40.0f, 260.0f, 400.0f);
    messageViewController.metric = self.metric;
    [messageViewController averageForRadialView:[NSNumber numberWithDouble:4.8]];
    [self.tableView setUserInteractionEnabled:NO];
    [messageViewController.view addSubview:popUpLabel];
    
    self.navigationController.useBlurForPopup = YES;
    self.paperFoldNavController.paperFoldView.enableLeftFoldDragging = NO;
    [self.navigationController presentPopupViewController:messageViewController animated:YES completion:nil];
    
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

#pragma RMStepsControllerDelegate

- (void) stepsControllerdidFinishSteps:(RMStepsController *)stepsController {
    [self performSegueWithIdentifier:@"showScore" sender:self];
}

//for message popup
- (void)dismissPopup {
    if (self.navigationController.popupViewController != nil) {
        self.paperFoldNavController.paperFoldView.enableLeftFoldDragging = YES;
        [self.navigationController.view removeGestureRecognizer:self.tapRecognizer];
        [self.navigationController dismissPopupViewControllerAnimated:YES completion:^{
            NSLog(@"popup view dismissed");
        }];
        [self.tableView setUserInteractionEnabled:YES];
    }
}

#pragma mark - gesture recognizer delegate functions

// so that tapping popup view doesnt dismiss it
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view == self.view;
}



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAssessment"]) {
        ForecastStepsController *forecastStepsController = segue.destinationViewController;
        forecastStepsController.delegate = self;
        forecastStepsController.assessment = self.metric.assessment;
    }
    else if ([segue.identifier isEqualToString:@"showScore"]) {
        UINavigationController *navController = segue.destinationViewController;
        ScoreViewController *scoreViewController = navController.topViewController;
        scoreViewController.score = [self.metric.assessment score];
        scoreViewController.graphName = self.metric.graphName;
        scoreViewController.graphColor = self.metric.graphColor;
    }
    
}





@end























