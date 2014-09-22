//
//  DailySpaceTableViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "DailySpaceTableViewController.h"
#import "MainTabBarController.h"
#import "DailySpaceCell.h"
#import "SaveTableViewCell.h"
#import "ForecastStepsController.h"
#import "ScoreViewController.h"
#import "CalendarViewController.h"
#import "UIColor+colors.h"
#import "Assessment.h"
#import "CWRatingView.h"
#import "UIFont+fonts.h"
#import "UIViewController+CWPopup.h"
#import "ChartPopViewController.h"

#define CELLHEIGHT 81

@interface DailySpaceTableViewController ()

@property (strong, nonatomic) MainTabBarController *mainTabBarController;
@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;

@property (strong, nonatomic) UIButton *saveButton;

@property (strong, nonatomic) Assessment *eatingAssessment;
@property (strong, nonatomic) Assessment *presenceAssessment;
@property (strong, nonatomic) NSDate *date;

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@end

@implementation DailySpaceTableViewController

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
    [self.navigationController setNavigationBarHidden:YES];

    
    [self setAssesments];
    self.mainTabBarController = (MainTabBarController *)self.navigationController.parentViewController;
    //MainTabBarController *paperFoldTabBarController = self.navigationController.parentViewController;
    //self.paperFoldNavController = paperFoldTabBarController.paperFoldNavController;

    self.date = [NSDate date];
    
    self.view.clipsToBounds = YES;
    /*
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopup)];
    self.tapRecognizer.numberOfTapsRequired = 1;
    self.tapRecognizer.delegate = self.tableView;
     */
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [self.navigationItem setTitle:[formatter stringFromDate:self.date]];
    
    self.navigationController.navigationBar.tintColor = [UIColor OPAquaColor];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:[UIColor OPAquaColor] forKey:@"NSColor"];
    [attributes setObject:[UIFont mainFontWithSize:27.0f] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    
    //[self.saveButton setEnabled:NO];
    [self.saveButton setTitleColor:[UIColor OPGreyTextColor] forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.item < 5) {
        DailySpaceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dailySpaceCell" forIndexPath:indexPath];
        [cell setTableViewController:self];
        
        if (indexPath.item == 0) {
            [cell setCellName:@"Sleep"];
            [cell setCellColor:[UIColor OPRedColor]];
        }
        else if (indexPath.item == 1) {
            [cell setCellName:@"Presence"];
            [cell setCellColor:[UIColor OPBlueColor]];
        }
        else if (indexPath.item == 2) {
            [cell setCellName:@"Activity"];
            [cell setCellColor:[UIColor OPYellowColor]];
        }
        else if (indexPath.item == 3) {
            [cell setCellName:@"Creativity"];
            [cell setCellColor:[UIColor OPAquaColor]];
        }
        else if (indexPath.item == 4) {
            [cell setCellName:@"Eating"];
            [cell setCellColor:[UIColor OPOrangeColor]];
        }
        
        return cell;
    }
    else {
        SaveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"saveCell" forIndexPath:indexPath];
        self.saveButton = cell.saveButton;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELLHEIGHT;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)savePressed:(id)sender {
    
    
}

- (IBAction)menuPressed:(id)sender {
    /*
    if (self.paperFoldNavController.paperFoldView.state == PaperFoldStateLeftUnfolded) {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    } else {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateLeftUnfolded animated:YES];
    }*/
    [self.mainTabBarController showMenu];
}

- (IBAction)assessmentPressed:(id)sender {
    
    ChartPopViewController *chartPopUpViewController = self.parentViewController.parentViewController;\
    [chartPopUpViewController showAssessment];
    
    if ([((DailySpaceCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).assessmentButton isEqual:sender]){
        
        [self performSegueWithIdentifier:@"showAssessment" sender:sender];
    }
    else if ([((DailySpaceCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]).assessmentButton isEqual:sender]){
        [self performSegueWithIdentifier:@"showAssessment" sender:sender];
    }
}

- (IBAction)calendarPressed:(id)sender {
    
    //[self.tableView addGestureRecognizer:self.tapRecognizer];
    
    UIView *calenderBackround = [[UIView alloc] initWithFrame:CGRectMake(-5.0, -5.0, 290, 285)];
    [calenderBackround setBackgroundColor:[UIColor whiteColor]];
    [calenderBackround.layer setCornerRadius:10.0];
    calenderBackround.clipsToBounds = YES;
    
    UILabel *popUpLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, -50.0, 280.0, 40.0)];
    [popUpLabel setTextColor:[UIColor whiteColor]];
    [popUpLabel setText:@"pick a day"];
    [popUpLabel setFont:[UIFont mainFontWithSize:28.0]];
    [popUpLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    CalendarViewController *calenderViewController = [[CalendarViewController alloc] init];
    calenderViewController.delegate = self;
    calenderViewController.currentDate = self.date;
    calenderViewController.view.frame = CGRectMake(0.0, 200.0, 280.0, 280.0);
    [calenderViewController.view addSubview:calenderBackround];
    [calenderViewController.view sendSubviewToBack:calenderBackround];
    [calenderViewController.view addSubview:popUpLabel];
    
    self.mainTabBarController.useBlurForPopup = YES;
    self.paperFoldNavController.paperFoldView.enableLeftFoldDragging = NO;
    [self.mainTabBarController presentPopupViewController:calenderViewController animated:YES completion:nil];
    
}

 
#pragma CWRadioButtonDelegate;

- (void)buttonSelected:(UIButton *)button {
    
    NSIndexPath* index;
    BOOL allSelected = YES;
    
    for (int i=0; i < 5; i++) {
        index = [NSIndexPath indexPathForRow:i inSection:0];
        DailySpaceCell *cell = [self.tableView cellForRowAtIndexPath:index];
        if (!cell.buttons.selectedButton) {
            allSelected = NO;
        }
    }
    
    if (allSelected) {
        [self.saveButton setEnabled:YES];
        [self.saveButton setTitleColor:[UIColor OPGreyTextColor] forState:UIControlStateNormal];
    }
    
}

#pragma RMStepsControllerDelegate

- (void)stepsControllerdidFinishSteps:(RMStepsController *)stepsController {
    
    Assessment *assessment = ((ForecastStepsController *)stepsController).assessment;
    DailySpaceCell *cell;
    if ([self.presenceAssessment isEqual:assessment]) {
        cell = (DailySpaceCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    }
    else if ([self.eatingAssessment isEqual:assessment]) {
        cell = (DailySpaceCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    }
    
    float score = [[assessment score] floatValue];
    if (score < 1.5) {
        [cell.slider setValue:1.0];
        //[cell.buttons setButtonsSelectedButton:cell.button1];
        //[cell.ratingView selectChoice:0];
    }
    else if (score < 2.5) {
        [cell.slider setValue:2.0];
        //[cell.buttons setButtonsSelectedButton:cell.button2];
        //[cell.ratingView selectChoice:1];
    }
    else if (score < 3.5) {
        [cell.slider setValue:3.0];
        //[cell.buttons setButtonsSelectedButton:cell.button3];
        //[cell.ratingView selectChoice:2];
    }
    else if (score < 4.5) {
        [cell.slider setValue:4.0];
        //[cell.buttons setButtonsSelectedButton:cell.button4];
        //[cell.ratingView selectChoice:3];
    }
    else {
        [cell.slider setValue:5.0];
        //[cell.buttons setButtonsSelectedButton:cell.button5];
        //[cell.ratingView selectChoice:4];
    }
    //[self performSegueWithIdentifier:@"showScore" sender:assessment];
}

#pragma CalendarViewControllerDelegate

- (void)calendarDidPickDate:(NSDate *) date {

    self.date = date;
    NSDateFormatter *formatter;
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    [self.navigationItem setTitle:[formatter stringFromDate:self.date]];
    [self.mainTabBarController dismissPopupViewControllerAnimated:YES completion:nil];
}

- (void) setAssesments {
    
    self.eatingAssessment = [[Assessment alloc] init];
    self.eatingAssessment.graphName = @"Eating";
    self.eatingAssessment.graphColor = [UIColor OPOrangeColor];
    

    [self.eatingAssessment addMultipleQuestion:@"How much olive oil do you consume PER DAY (including that used in frying, salads and meals eaten away from home)?" Choices:@[@"none", @"2 tablespoons", @"4 tablespoons", @"6 tablespoons", @"8 or more"] PointsForAnswers:@[@0,@0,@1,@1,@1]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of vegetables do you consume PER DAY? [A serving is 200 g.]" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"] PointsForAnswers:@[@0,@0,@1,@1,@1]];
    [self.eatingAssessment addMultipleQuestion:@"How many pieces of fruit do you consume PER DAY?" Choices:@[@"none", @"1 piece", @"2 pieces", @"3 pieces", @"4 or more pieces"] PointsForAnswers:@[@0,@0,@0,@1,@1]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of red meat, hamburger, or sausages do you consume PER DAY?" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"] PointsForAnswers:@[@1,@0,@0,@0,@0]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of butter, margarine, or cream do you consume PER DAY?" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"] PointsForAnswers:@[@1,@0,@0,@0,@0]];
    [self.eatingAssessment addMultipleQuestion:@"How many carbonated and/or sugar-sweetened beverages do you consume PER DAY?" Choices:@[@"none", @"1 beverage", @"2 beverages", @"3 beverages", @"4 or more beverages"] PointsForAnswers:@[@1,@0,@0,@0,@0]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings (150 g) of beans, peas, or lentils do you consume PER WEEK? [A serving is 150 g.]" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"] PointsForAnswers:@[@0,@0,@1,@1,@1]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of whole grain foods such as couscous, oats, quinoa, brown or wild rice did you eat?" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"] PointsForAnswers:@[@0,@0,@1,@1,@1]];
    [self.eatingAssessment addMultipleQuestion:@"How many times do you consume commercial (not homemade) pastry such as cookies or cake PER WEEK?" Choices:@[@"none", @"once", @"twice", @"3 times", @"4 or more times"] PointsForAnswers:@[@1,@0,@0,@0,@0]];
    [self.eatingAssessment addYesNoQuestion:@"Have you eaten a serving of nuts in the past week?" Accept:YES];
    
    
    
    self.presenceAssessment = [[Assessment alloc] init];
    self.presenceAssessment.graphName = @"Presence";
    self.presenceAssessment.graphColor = [UIColor OPBlueColor];
    
    [self.presenceAssessment addScaleQuestion:@"When I have distressing thoughts or images, I just notice them and let them go."];
    [self.presenceAssessment addScaleQuestion:@"It seems I am “running automatic” without much awareness of what I’m doing."];
    [self.presenceAssessment addScaleQuestion:@"It’s hard for me to find the words to describe what I’m feeling or thinking."];
    [self.presenceAssessment addScaleQuestion:@"I tell myself that I shouldn’t be thinking or feeling the way I’m thinking or feeling."];
    [self.presenceAssessment addScaleQuestion:@"I pay attention to physical experiences, such as the wind in my hair or the smells of things."];
    
}

#pragma mark - gesture recognizer delegate functions

// so that tapping popup view doesnt dismiss it
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return touch.view == self.view;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showAssessment"]) {
        
        [self.navigationItem setTitle:@"back"];
        
        //UINavigationController *navController = segue.destinationViewController;
        
        ForecastStepsController *forecastStepsController = segue.destinationViewController;//navController.topViewController;
        forecastStepsController.delegate = self;
        forecastStepsController.fullscreen = NO;
        
        if ([((DailySpaceCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).assessmentButton isEqual:sender]){
            forecastStepsController.assessment = self.presenceAssessment;
        }
        else if ([((DailySpaceCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]]).assessmentButton isEqual:sender]){
            forecastStepsController.assessment = self.eatingAssessment;
        }
    }
    else if ([segue.identifier isEqualToString:@"showScore"]) {
        Assessment *assessment = sender;
        ScoreViewController *scoreViewController = ((UINavigationController *)segue.destinationViewController).topViewController;
        if ([self.presenceAssessment isEqual:assessment]) {
            scoreViewController.score = [self.presenceAssessment score];
            scoreViewController.graphColor = self.presenceAssessment.graphColor;
            scoreViewController.graphName = self.presenceAssessment.graphName;
        }
        else if ([self.eatingAssessment isEqual:assessment]) {
            scoreViewController.score = [self.eatingAssessment score];
            scoreViewController.graphColor = self.eatingAssessment.graphColor;
            scoreViewController.graphName = self.eatingAssessment.graphName;
        }
    }
    else if ([segue.identifier isEqualToString:@"showCalendar"]) {
        
        CalendarViewController *calenderViewController = segue.destinationViewController;
        calenderViewController.delegate = self;
        calenderViewController.currentDate = self.date;
    }
    
}


@end




















