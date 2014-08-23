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



#define HEADERHEIGHT 555
#define CELLHEIGHT 55
#define EXPANDEDHEIGHT 140
#define BLANKCELLHEIGHT 20
#define degreesToRadians(x)(x * M_PI / 180)
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface SingleMetricTableViewController ()

@property (strong, nonatomic) SingleMetricViewController *singleMetricViewController;
@property (strong, nonatomic) NSMutableArray *cellHeight;

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
    
    self.navigationItem.title = self.graphName;
    
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    //previousStepperValue = self.graphObjectIncrement.value;
    totalNumber = 0;
    
    
    //self.ArrayOfDates = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    
    
    self.cellHeight = [[NSMutableArray alloc] initWithCapacity:self.ArrayOfValues.count];
    
    for (int i=0; i < self.ArrayOfValues.count; i++) {
        [self.cellHeight addObject:[NSNumber numberWithFloat:CELLHEIGHT]];
    }
    
    //set navController color and font
    self.navigationController.navigationBar.tintColor = self.graphColor;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:self.graphColor forKey:@"NSColor"];
    [attributes setObject:[UIFont fontWithName:@"Museo-500" size:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    NSDictionary *backButtonAttricbutes = [NSDictionary dictionaryWithObjectsAndKeys:
                                           [UIFont fontWithName:@"Museo-500" size:20],
                                           NSFontAttributeName,
                                           nil];
    [self.backButton setTitleTextAttributes:backButtonAttricbutes forState:UIControlStateNormal];
    

    
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
        self.singleMetricViewController.graphColor = self.graphColor;
        self.singleMetricViewController.graphName = self.graphName;
        self.singleMetricViewController.graphDefinition = self.graphDefinition;
        
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
        
        UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:28];
        [cell.valueLabel setFont:font];
        [cell.valueLabel setText:[NSString stringWithFormat:@"%@.0", (NSNumber *)[self.ArrayOfValues objectAtIndex:indexPath.item]]];
        [cell.valueLabel setTextColor:self.graphColor];
        
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
    [attributes setObject:[UIFont fontWithName:@"Museo-700" size:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void) showAssesment {
    if (self.assessment) {
        [self performSegueWithIdentifier:@"showAssesment" sender:self];
    }
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

- (void) didFinishSteps {
    [self performSegueWithIdentifier:@"showSteps" sender:self];
}


- (NSNumber *) computeScore {
    
    NSArray *answers = self.assessment.answers;
    

    if ([self.graphName isEqualToString:@"Presence"]) {
        return [answers valueForKeyPath:@"@avg.self"];
    }
    else if ([self.graphName isEqualToString:@"Eating"]) {
        NSInteger total = 0;
        
        NSInteger answer = [((NSNumber *)[answers objectAtIndex:0]) intValue];
        if (answer == 1) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:1]) intValue];
        if (answer >= 3) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:2]) intValue];
        if (answer >= 3) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:3]) intValue];
        if (answer >= 4) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:4]) intValue];
        if (answer == 1) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:5]) intValue];
        if (answer == 1) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:6]) intValue];
        if (answer == 1) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:7]) intValue];
        if (answer == 5) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:8]) intValue];
        if (answer >= 4) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:9]) intValue];
        if (answer >= 4) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:10]) intValue];
        if (answer < 3) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:11]) intValue];
        if (answer >= 4) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:12]) intValue];
        if (answer == 1) {
            total++;
        }
        answer = [((NSNumber *)[answers objectAtIndex:13]) intValue];
        if (answer >= 3) {
            total++;
        }
        
        return [NSNumber numberWithFloat: 5*total/14.0f];
    }
    else return [NSNumber numberWithInt:0];
    
}




- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAssesment"]) {
        ForecastStepsController *forecastStepsController = segue.destinationViewController;
        forecastStepsController.delegate = self;
        forecastStepsController.graphName = self.graphName;
        forecastStepsController.graphColor = self.graphColor;
        forecastStepsController.assessment = self.assessment;
    }
    else if ([segue.identifier isEqualToString:@"showSteps"]) {
        UINavigationController *navController = segue.destinationViewController;
        ScoreViewController *scoreViewController = navController.topViewController;
        scoreViewController.score = [self computeScore];
        scoreViewController.graphName = self.graphName;
        scoreViewController.graphColor = self.graphColor;
    }
}





@end























