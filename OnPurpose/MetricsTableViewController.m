//
//  MetricsTableViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "MetricsTableViewController.h"
#import "MetricTableViewCell.h"
#import "SingleMetricTableViewController.h"
#import "PaperFoldTabBarController.h"
#import "Assessment.h"
#import "Constants.h"
#import "UIColor+colors.h"
#import "Metric.h"

#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

@interface MetricsTableViewController ()

@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;
@property (strong, nonatomic) PFLogInViewController *parseLogInViewController;

@property (strong, nonatomic) NSNumber *sleepAverage;
@property (strong, nonatomic) NSNumber *presenceAverage;
@property (strong, nonatomic) NSNumber *activityAverage;
@property (strong, nonatomic) NSNumber *creativityAverage;
@property (strong, nonatomic) NSNumber *eatingAverage;

@property (strong, nonatomic) PFUser *lastUser;

@end

@implementation MetricsTableViewController

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
    
    
    
    PaperFoldTabBarController *paperFoldTabBarController = self.navigationController.parentViewController;
    self.paperFoldNavController = paperFoldTabBarController.paperFoldNavController;
    
    
    self.sleepArray = [[NSMutableArray alloc] init];
    self.presenceArray = [[NSMutableArray alloc] init];
    self.activityArray = [[NSMutableArray alloc] init];
    self.creativityArray = [[NSMutableArray alloc] init];
    self.eatingArray = [[NSMutableArray alloc] init];
    self.metricDaysArray = [[NSMutableArray alloc] init];
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkForUser];
    if (self.lastUser != [PFUser currentUser]) {
        self.lastUser = [PFUser currentUser];
        self.sleepArray = [[NSMutableArray alloc] init];
        self.presenceArray = [[NSMutableArray alloc] init];
        self.activityArray = [[NSMutableArray alloc] init];
        self.creativityArray = [[NSMutableArray alloc] init];
        self.eatingArray = [[NSMutableArray alloc] init];
        self.metricDaysArray = [[NSMutableArray alloc] init];
        self.ArrayOfDates = [[NSMutableArray alloc] init];
        
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
                [self.metricDaysArray addObject:(NSDate *)[object objectForKey:metricsDayKey]];
            }
            //totalNumber = self.sleepArray.count;
            //[self layoutStats];
            [self refreshAnimaions];
            [self layout];
            [self.tableView reloadData];
        }];
        
    }
    else {
        [self refreshAnimaions];
    }
    
    /*
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    //[attributes setObject:[UIColor colorWithRed:69.0/255.0 green:97.0/255.0 blue:115.0/255.0 alpha:1.0] forKey:@"NSColor"];
    //[attributes setObject:[UIColor blackColor] forKey:@"NSColor"];
    [attributes setObject:[UIFont mainFontWithSize:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
     */
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"On Purpose"];
    [title addAttribute:NSFontAttributeName value:[UIFont mainFontLightWithSize:27] range:NSMakeRange(0, 2)];
    [title addAttribute:NSFontAttributeName value:[UIFont mainFontBoldWithSize:27] range:NSMakeRange(3, 7)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 150)];
    [label setAttributedText:title];
    [label setTextColor:[UIColor OPAquaColor]];
    self.navigationItem.titleView = label;
    
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

- (void) refreshAnimaions {
    
    for (NSInteger i=0; i < [self tableView:self.tableView numberOfRowsInSection:0]; i++) {
        [((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]]) refreshAnimations];
    }
    
    
    
}

- (void)layout {
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    [self.ArrayOfDates addObject:@""];
    for (int i=1; i < self.metricDaysArray.count; i++) {
        NSString *day = [dateFormatter stringFromDate:[self.metricDaysArray objectAtIndex:i]];
        [self.ArrayOfDates addObject:[day substringToIndex:1]];
    }
    [self.ArrayOfDates addObject:@""];
    
}


- (void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self.parseLogInViewController dismissViewControllerAnimated:YES completion:nil];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MetricTableViewCell *cell;
    
    // Configure the cell...
    if (indexPath.item == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initSleep]];
        [cell graphValues:self.sleepArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initPresence]];
        [cell graphValues:self.presenceArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 2) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initActivity]];
        [cell graphValues:self.activityArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 3) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initCreativity]];
        [cell graphValues:self.creativityArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 4) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initEating]];
        [cell graphValues:self.eatingArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 5) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initEnergy]];
        [cell graphValues:self.activityArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 6) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initSelfControl]];
        [cell graphValues:self.creativityArray dates:self.ArrayOfDates];
    }
    else if (indexPath.item == 7) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"metricCell" forIndexPath:indexPath];
        [cell metricForCell:[[Metric alloc] initVitality]];
        [cell graphValues:self.eatingArray dates:self.ArrayOfDates];
    }
    

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.item < 5) {
        MetricTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"showMetric" sender:cell];
    }
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (IBAction)menuPressed:(id)sender {
    
    if (self.paperFoldNavController.paperFoldView.state == PaperFoldStateLeftUnfolded) {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    } else {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateLeftUnfolded animated:YES];
    }
    
}


#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    
    if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).graph]) {
        return (int)[self.sleepArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).graph]) {
        return (int)[self.presenceArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).graph]) {
        return (int)[self.activityArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).graph]) {
        return (int)[self.creativityArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]).graph]) {
        return (int)[self.eatingArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]]).graph]) {
        return (int)[self.activityArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]]).graph]) {
        return (int)[self.creativityArray count];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]]).graph]) {
        return (int)[self.eatingArray count];
    }
    else return 0;
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    
    if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]).graph]) {
        return [[self.sleepArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).graph]) {
        return [[self.presenceArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).graph]) {
        return [[self.activityArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).graph]) {
        return [[self.creativityArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]).graph]) {
        return [[self.eatingArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]]).graph]) {
        return [[self.activityArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]]).graph]) {
        return [[self.creativityArray objectAtIndex:index] floatValue];
    }
    else if ([graph isEqual:((MetricTableViewCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]]).graph]) {
        return [[self.eatingArray objectAtIndex:index] floatValue];
    }
    else return 0;
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 0;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    return [self.ArrayOfDates objectAtIndex:index];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
    //self.labelValues.text = [NSString stringWithFormat:@"%@", [self.sleepArray objectAtIndex:index]];
    //self.labelDates.text = [NSString stringWithFormat:@"in %@", [self.ArrayOfDates objectAtIndex:index]];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
    /*
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
     */
}


- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    /*
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.sleepGraph calculatePointValueSum] intValue]];
    self.labelDates.text = [NSString stringWithFormat:@"between 2000 and %@", [self.ArrayOfDates lastObject]];
     */
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        singleMetricTableViewController.paperFoldNavContoller = self.paperFoldNavController;
        if ([sender isEqual:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]]]) {
            singleMetricTableViewController.ArrayOfValues = self.sleepArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initSleep];
            
        }
        else if ([sender isEqual:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]]) {
            singleMetricTableViewController.ArrayOfValues = self.presenceArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initPresence];
        }
        else if ([sender isEqual:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]]) {
            singleMetricTableViewController.ArrayOfValues = self.activityArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initActivity];
        }
        else if ([sender isEqual:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]]) {
            singleMetricTableViewController.ArrayOfValues = self.creativityArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initCreativity];
        }
        else if ([sender isEqual:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]]) {
            singleMetricTableViewController.ArrayOfValues = self.eatingArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initEating];
        }
    }
    
}




@end