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


#define HEADERHEIGHT 470
#define CELLHEIGHT 55
#define EXPANDEDHEIGHT 140
#define degreesToRadians(x)(x * M_PI / 180)

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
    
    
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
    //previousStepperValue = self.graphObjectIncrement.value;
    totalNumber = 0;
    
    
    self.ArrayOfDates = [NSMutableArray arrayWithObjects:@"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat", @"Sun", nil];
    
    self.cellHeight = [[NSMutableArray alloc] initWithCapacity:self.ArrayOfValues.count];
    
    for (int i=0; i < self.ArrayOfValues.count; i++) {
        [self.cellHeight addObject:[NSNumber numberWithFloat:CELLHEIGHT]];
    }
    
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
    else return self.ArrayOfValues.count;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    
    if (section == 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.singleMetricViewController = [storyboard instantiateViewControllerWithIdentifier:@"SingleMetricViewController"];
        self.singleMetricViewController.ArrayOfValues = self.ArrayOfValues;
        self.singleMetricViewController.graphColor = self.graphColor;
        self.singleMetricViewController.graphName = self.graphName;
        
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
    SingleMetricDayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dayCell" forIndexPath:indexPath];
    if (indexPath.item == 0) {
        [cell.dayLabel setText:@"January 1st"];
    }
    else if (indexPath.item == 1) {
        [cell.dayLabel setText:@"January 2nd"];
    }
    else if (indexPath.item == 2) {
        [cell.dayLabel setText:@"January 3rd"];
    }
    else {
        [cell.dayLabel setText:[NSString stringWithFormat:@"January %ldth", (long)(indexPath.item + 1)]];
    }
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [(NSNumber *)[self.cellHeight objectAtIndex:indexPath.item] floatValue];
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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0] forKey:@"NSColor"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    [self.navigationController popViewControllerAnimated:YES];
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








