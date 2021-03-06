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
#import "MainTabBarController.h"
#import "Assessment.h"
#import "Constants.h"
#import "UIColor+colors.h"

#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface MetricsViewController () {
    int previousStepperValue;
    int totalNumber;
    
}



@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;
@property (strong, nonatomic) PFLogInViewController *parseLogInViewController;

@property (strong, nonatomic) MDRadialProgressView *sleepRadialView;
@property (strong, nonatomic) MDRadialProgressView *presenceRadialView;
@property (strong, nonatomic) MDRadialProgressView *activityRadialView;
@property (strong, nonatomic) MDRadialProgressView *creativityRadialView;
@property (strong, nonatomic) MDRadialProgressView *eatingRadialView;

@property (strong, nonatomic) NSNumber *sleepAverage;
@property (strong, nonatomic) NSNumber *presenceAverage;
@property (strong, nonatomic) NSNumber *activityAverage;
@property (strong, nonatomic) NSNumber *creativityAverage;
@property (strong, nonatomic) NSNumber *eatingAverage;

@property (strong, nonatomic) Assessment *eatingAssessment;
@property (strong, nonatomic) Assessment *presenceAssessment;

@property (strong, nonatomic) PFUser *lastUser;

@end

@implementation MetricsViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setAssesments];
    
    MainTabBarController *paperFoldTabBarController = self.navigationController.parentViewController;
    self.paperFoldNavController = paperFoldTabBarController.paperFoldNavController;
    
    
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
    //self.ArrayOfDates = [NSArray arrayWithObjects: @"", @"T",  @"W", @"T",  @"F", @"S",  @"S", @"", @"", @"", @"", @"",  nil];
    
    /* This is commented out because the graph is created in the interface with this sample app. However, the code remains as an example for creating the graph using code.
     BEMSimpleLineGraphView *sleepGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, 320, 250)];
     sleepGraph.delegate = self;
     [self.view addSubview:sleepGraph]; */
    
    NSInteger graphMin = 2;
    NSInteger graphMax = 5;
    /*
    // Customization of the graph
    self.sleepGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.sleepGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.sleepGraph.colorLine = [UIColor whiteColor];
    self.sleepGraph.colorXaxisLabel = [UIColor whiteColor];
    self.sleepGraph.widthLine = 3.0;
    self.sleepGraph.enableTouchReport = YES;
    self.sleepGraph.enablePopUpReport = YES;
    self.sleepGraph.enableBezierCurve = YES;
    self.sleepGraph.min = graphMin;
    self.sleepGraph.max = graphMax;
    
    self.presenceGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.presenceGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.presenceGraph.colorLine = [UIColor whiteColor];
    self.presenceGraph.colorXaxisLabel = [UIColor whiteColor];
    self.presenceGraph.widthLine = 3.0;
    self.presenceGraph.enableTouchReport = YES;
    self.presenceGraph.enablePopUpReport = YES;
    self.presenceGraph.enableBezierCurve = YES;
    self.presenceGraph.min = graphMin;
    self.presenceGraph.max = graphMax;
    
    self.activityGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0];
    self.activityGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.activityGraph.colorLine = [UIColor whiteColor];
    self.activityGraph.colorXaxisLabel = [UIColor whiteColor];
    self.activityGraph.widthLine = 3.0;
    self.activityGraph.enableTouchReport = YES;
    self.activityGraph.enablePopUpReport = YES;
    self.activityGraph.enableBezierCurve = YES;
    self.activityGraph.min = graphMin;
    self.activityGraph.max = graphMax;
    
    self.creativityGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.creativityGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.creativityGraph.colorLine = [UIColor whiteColor];
    self.creativityGraph.colorXaxisLabel = [UIColor whiteColor];
    self.creativityGraph.widthLine = 3.0;
    self.creativityGraph.enableTouchReport = YES;
    self.creativityGraph.enablePopUpReport = YES;
    self.creativityGraph.enableBezierCurve = YES;
    self.creativityGraph.min = graphMin;
    self.creativityGraph.max = graphMax;
    
    self.eatingGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.eatingGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.eatingGraph.colorLine = [UIColor whiteColor];
    self.eatingGraph.colorXaxisLabel = [UIColor whiteColor];
    self.eatingGraph.widthLine = 3.0;
    self.eatingGraph.enableTouchReport = YES;
    self.eatingGraph.enablePopUpReport = YES;
    self.eatingGraph.enableBezierCurve = YES;
    self.eatingGraph.min = graphMin;
    self.eatingGraph.max = graphMax;
    */
    
    
    // Customization of the graph
    self.sleepGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.sleepGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.sleepGraph.colorLine = [UIColor OPRedColor];
    self.sleepGraph.colorXaxisLabel = [UIColor OPRedColor];
    self.sleepGraph.widthLine = 3.0;
    self.sleepGraph.enableTouchReport = YES;
    self.sleepGraph.enablePopUpReport = YES;
    self.sleepGraph.enableBezierCurve = YES;
    self.sleepGraph.min = graphMin;
    self.sleepGraph.max = graphMax;
    
    self.presenceGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.presenceGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.presenceGraph.colorLine = [UIColor OPBlueColor];
    self.presenceGraph.colorXaxisLabel = [UIColor OPBlueColor];
    self.presenceGraph.widthLine = 3.0;
    self.presenceGraph.enableTouchReport = YES;
    self.presenceGraph.enablePopUpReport = YES;
    self.presenceGraph.enableBezierCurve = YES;
    self.presenceGraph.min = graphMin;
    self.presenceGraph.max = graphMax;
    
    self.activityGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0];
    self.activityGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:255.0/255.0 green:187.0/255.0 blue:31.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.activityGraph.colorLine = [UIColor OPYellowColor];
    self.activityGraph.colorXaxisLabel = [UIColor OPYellowColor];
    self.activityGraph.widthLine = 3.0;
    self.activityGraph.enableTouchReport = YES;
    self.activityGraph.enablePopUpReport = YES;
    self.activityGraph.enableBezierCurve = YES;
    self.activityGraph.min = graphMin;
    self.activityGraph.max = graphMax;
    
    self.creativityGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.creativityGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.creativityGraph.colorLine = [UIColor OPAquaColor];
    self.creativityGraph.colorXaxisLabel = [UIColor OPAquaColor];
    self.creativityGraph.widthLine = 3.0;
    self.creativityGraph.enableTouchReport = YES;
    self.creativityGraph.enablePopUpReport = YES;
    self.creativityGraph.enableBezierCurve = YES;
    self.creativityGraph.min = graphMin;
    self.creativityGraph.max = graphMax;
    
    self.eatingGraph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0];
    self.eatingGraph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:0.0 green:140.0/255.0 blue:255.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.eatingGraph.colorLine = [UIColor OPOrangeColor];
    self.eatingGraph.colorXaxisLabel = [UIColor OPOrangeColor];
    self.eatingGraph.widthLine = 3.0;
    self.eatingGraph.enableTouchReport = YES;
    self.eatingGraph.enablePopUpReport = YES;
    self.eatingGraph.enableBezierCurve = YES;
    self.eatingGraph.min = graphMin;
    self.eatingGraph.max = graphMax;
    
    
    
    // The labels to report the values of the graph when the user touches it
    self.labelValues.text = [NSString stringWithFormat:@"%i", [[self.sleepGraph calculatePointValueSum] intValue]];
    self.labelDates.text = @"between 2000 and 2010";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            totalNumber = self.sleepArray.count;
            [self layoutStats];
            [self refresh:nil];
        }];

    }
    else {
        [self refresh:nil];
    }

    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    //[attributes setObject:[UIColor colorWithRed:69.0/255.0 green:97.0/255.0 blue:115.0/255.0 alpha:1.0] forKey:@"NSColor"];
    //[attributes setObject:[UIColor blackColor] forKey:@"NSColor"];
    [attributes setObject:[UIFont fontWithName:@"Museo-700" size:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
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

- (IBAction)menuPressed:(id)sender {
    
    if (self.paperFoldNavController.paperFoldView.state == PaperFoldStateLeftUnfolded) {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    } else {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateLeftUnfolded animated:YES];
    }
    
}

- (IBAction)refresh:(id)sender {
    
    [self.sleepGraph reloadGraph];
    [self.presenceGraph reloadGraph];
    [self.activityGraph reloadGraph];
    [self.creativityGraph reloadGraph];
    [self.eatingGraph reloadGraph];
    
    self.sleepRadialView.progressCounter = 0;
    [self radialView:self.sleepRadialView incrementAverage:self.sleepAverage];
    
    self.presenceRadialView.progressCounter = 0;
    [self radialView:self.presenceRadialView incrementAverage:self.presenceAverage];
    
    self.activityRadialView.progressCounter = 0;
    [self radialView:self.activityRadialView incrementAverage:self.activityAverage];
    
    self.creativityRadialView.progressCounter = 0;
    [self radialView:self.creativityRadialView incrementAverage:self.creativityAverage];
    
    self.eatingRadialView.progressCounter = 0;
    [self radialView:self.eatingRadialView incrementAverage:self.eatingAverage];
    
}

- (void)layoutStats {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    
    UIFont *font = [UIFont fontWithName:@"Montserrat-Regular" size:27];
    
    CGRect radialAverageRect;
    
    /*
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.sliceDividerHidden = YES;
    theme.completedColor = [UIColor whiteColor];
    theme.incompletedColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:.5];
    theme.labelColor = [UIColor clearColor];
    
    self.sleepAverage = [self.sleepArray valueForKeyPath:@"@avg.self"];
    [self.sleepValueLabel setText:[formatter stringFromNumber:self.sleepAverage]];
    [self.sleepValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 90, 70, 70);
    self.sleepRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.sleepRadialView.progressTotal = 500;
    self.sleepRadialView.progressCounter = 0;
    [self.view addSubview:self.sleepRadialView];
    
    
    
    self.presenceAverage = [self.presenceArray valueForKeyPath:@"@avg.self"];
    [self.presenceValueLabel setText:[formatter stringFromNumber:self.presenceAverage]];
    [self.presenceValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 190, 70, 70);
    self.presenceRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.presenceRadialView.progressTotal = 500;
    self.presenceRadialView.progressCounter = 0;
    [self.view addSubview:self.presenceRadialView];
    
    
    self.activityAverage = [self.activityArray valueForKeyPath:@"@avg.self"];
    [self.activityValueLabel setText:[formatter stringFromNumber:self.activityAverage]];
    [self.activityValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 290, 70, 70);
    self.activityRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.activityRadialView.progressTotal = 500;
    self.activityRadialView.progressCounter = 0;
    [self.view addSubview:self.activityRadialView];
    
    
    self.creativityAverage = [self.creativityArray valueForKeyPath:@"@avg.self"];
    [self.creativityValueLabel setText:[formatter stringFromNumber:self.creativityAverage]];
    [self.creativityValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 390, 70, 70);
    self.creativityRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.creativityRadialView.progressTotal = 500;
    self.creativityRadialView.progressCounter = 0;
    [self.view addSubview:self.creativityRadialView];
    
    
    self.eatingAverage = [self.eatingArray valueForKeyPath:@"@avg.self"];
    [self.eatingValueLabel setText:[formatter stringFromNumber:self.eatingAverage]];
    [self.eatingValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 490, 70, 70);
    self.eatingRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.eatingRadialView.progressTotal = 500;
    self.eatingRadialView.progressCounter = 0;
    [self.view addSubview:self.eatingRadialView];
    */
    
    
    
    MDRadialProgressTheme *sleepTheme = [[MDRadialProgressTheme alloc] init];
    sleepTheme.sliceDividerHidden = YES;
    sleepTheme.completedColor = [UIColor OPRedColor];
    sleepTheme.incompletedColor = [[UIColor OPRedColor] colorWithAlphaComponent:.5];
    sleepTheme.labelColor = [UIColor clearColor];
    
    self.sleepAverage = [self.sleepArray valueForKeyPath:@"@avg.self"];
    [self.sleepValueLabel setText:[formatter stringFromNumber:self.sleepAverage]];
    [self.sleepValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 90, 70, 70);
    self.sleepRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:sleepTheme];
    self.sleepRadialView.progressTotal = 500;
    self.sleepRadialView.progressCounter = 0;
    [self.view addSubview:self.sleepRadialView];
    
    
    MDRadialProgressTheme *presenceTheme = [[MDRadialProgressTheme alloc] init];
    presenceTheme.sliceDividerHidden = YES;
    presenceTheme.completedColor = [UIColor OPBlueColor];
    presenceTheme.incompletedColor = [[UIColor OPBlueColor] colorWithAlphaComponent:.5];
    presenceTheme.labelColor = [UIColor clearColor];
    
    self.presenceAverage = [self.presenceArray valueForKeyPath:@"@avg.self"];
    [self.presenceValueLabel setText:[formatter stringFromNumber:self.presenceAverage]];
    [self.presenceValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 190, 70, 70);
    self.presenceRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:presenceTheme];
    self.presenceRadialView.progressTotal = 500;
    self.presenceRadialView.progressCounter = 0;
    [self.view addSubview:self.presenceRadialView];
    
    
    MDRadialProgressTheme *activityTheme = [[MDRadialProgressTheme alloc] init];
    activityTheme.sliceDividerHidden = YES;
    activityTheme.completedColor = [UIColor OPYellowColor];
    activityTheme.incompletedColor = [[UIColor OPYellowColor] colorWithAlphaComponent:.5];
    activityTheme.labelColor = [UIColor clearColor];
    
    self.activityAverage = [self.activityArray valueForKeyPath:@"@avg.self"];
    [self.activityValueLabel setText:[formatter stringFromNumber:self.activityAverage]];
    [self.activityValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 290, 70, 70);
    self.activityRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:activityTheme];
    self.activityRadialView.progressTotal = 500;
    self.activityRadialView.progressCounter = 0;
    [self.view addSubview:self.activityRadialView];
    
    
    
    MDRadialProgressTheme *creativityTheme = [[MDRadialProgressTheme alloc] init];
    creativityTheme.sliceDividerHidden = YES;
    creativityTheme.completedColor = [UIColor OPAquaColor];
    creativityTheme.incompletedColor = [[UIColor OPAquaColor] colorWithAlphaComponent:.5];
    creativityTheme.labelColor = [UIColor clearColor];
    
    self.creativityAverage = [self.creativityArray valueForKeyPath:@"@avg.self"];
    [self.creativityValueLabel setText:[formatter stringFromNumber:self.creativityAverage]];
    [self.creativityValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 390, 70, 70);
    self.creativityRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:creativityTheme];
    self.creativityRadialView.progressTotal = 500;
    self.creativityRadialView.progressCounter = 0;
    [self.view addSubview:self.creativityRadialView];
    
    
    
    MDRadialProgressTheme *eatingTheme = [[MDRadialProgressTheme alloc] init];
    eatingTheme.sliceDividerHidden = YES;
    eatingTheme.completedColor = [UIColor OPOrangeColor];
    eatingTheme.incompletedColor = [[UIColor OPOrangeColor] colorWithAlphaComponent:.5];
    eatingTheme.labelColor = [UIColor clearColor];
    
    self.eatingAverage = [self.eatingArray valueForKeyPath:@"@avg.self"];
    [self.eatingValueLabel setText:[formatter stringFromNumber:self.eatingAverage]];
    [self.eatingValueLabel setFont:font];
    
    radialAverageRect = CGRectMake(67, 490, 70, 70);
    self.eatingRadialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:eatingTheme];
    self.eatingRadialView.progressTotal = 500;
    self.eatingRadialView.progressCounter = 0;
    [self.view addSubview:self.eatingRadialView];
    
    
    
    self.ArrayOfDates = [[NSMutableArray alloc] init];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    [self.ArrayOfDates addObject:@""];
    for (int i=1; i < self.metricDaysArray.count; i++) {
        NSString *day = [dateFormatter stringFromDate:[self.metricDaysArray objectAtIndex:i]];
        [self.ArrayOfDates addObject:[day substringToIndex:1]];
    }
    [self.ArrayOfDates addObject:@""];

    
    [self.view bringSubviewToFront:self.sleepButton];
    [self.view bringSubviewToFront:self.presenceButton];
    [self.view bringSubviewToFront:self.activityButton];
    [self.view bringSubviewToFront:self.creativityButton];
    [self.view bringSubviewToFront:self.eatingButton];
    
    
    
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

    
    //old assessment
    /*
    [self.eatingAssessment addYesNoQuestion:@"Do you use olive oil as the principal source of fat for cooking?"];
    [self.eatingAssessment addMultipleQuestion:@"How much olive oil do you consume PER DAY (including that used in frying, salads and meals eaten away from home)?" Choices:@[@"none", @"2 tablespoons", @"4 tablespoons", @"6 tablespoons", @"8 or more"]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of vegetables do you consume PER DAY? [A serving is 200 g.]" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"]];
    [self.eatingAssessment addMultipleQuestion:@"How many pieces of fruit do you consume PER DAY?" Choices:@[@"none", @"1 piece", @"2 pieces", @"3 pieces", @"4 or more pieces"]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of red meat, hamburger, or sausages do you consume PER DAY?" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of butter, margarine, or cream do you consume PER DAY?" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"]];
    [self.eatingAssessment addMultipleQuestion:@"How many carbonated and/or sugar-sweetened beverages do you consume PER DAY?" Choices:@[@"none", @"1 beverage", @"2 beverages", @"3 beverages", @"4 or more beverages"]];
    [self.eatingAssessment addMultipleQuestion:@"Do you drink wine? How much do you consume PER WEEK? ONE POINT FOR: ≥7 cups" Choices:@[@"I don't drink wine", @"2 cups", @"4 cups", @"6 cups", @"7 or more cups"]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings (150 g) of beans, peas, or lentils do you consume PER WEEK? [A serving is 150 g.]" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"]];
    [self.eatingAssessment addMultipleQuestion:@"How many servings of fish/seafood do you consume PER WEEK? [A serving is 100–150 g of fish, 4–5 pieces or 200 g of seafood]" Choices:@[@"none", @"1 serving", @"2 servings", @"3 servings", @"4 or more servings"]];
    [self.eatingAssessment addMultipleQuestion:@"How many times do you consume commercial (not homemade) pastry such as cookies or cake PER WEEK?" Choices:@[@"none", @"once", @"twice", @"3 times", @"4 or more times"]];
    [self.eatingAssessment addMultipleQuestion:@"How many times do you consume nuts PER WEEK?" Choices:@[@"none", @"once", @"twice", @"3 times", @"4 or more times"]];
    [self.eatingAssessment addYesNoQuestion:@"Do you prefer to eat chicken, turkey or rabbit instead of beef, pork, hamburgers, or sausages?"];
    [self.eatingAssessment addMultipleQuestion:@"How many times PER WEEK do you consume boiled vegetables, pasta, rice, or other dishes with a sauce of tomato, garlic, onion, or leeks sautéed in olive oil?" Choices:@[@"none", @"once", @"twice", @"3 times", @"4 or more times"]];
    */
    
    
    self.presenceAssessment = [[Assessment alloc] init];
    self.presenceAssessment.graphName = @"Presence";
    self.presenceAssessment.graphColor = [UIColor OPBlueColor];
    
    
    [self.presenceAssessment addScaleQuestion:@"When I have distressing thoughts or images, I just notice them and let them go."];
    [self.presenceAssessment addScaleQuestion:@"It seems I am “running automatic” without much awareness of what I’m doing."];
    [self.presenceAssessment addScaleQuestion:@"It’s hard for me to find the words to describe what I’m feeling or thinking."];
    [self.presenceAssessment addScaleQuestion:@"I tell myself that I shouldn’t be thinking or feeling the way I’m thinking or feeling."];
    [self.presenceAssessment addScaleQuestion:@"I pay attention to physical experiences, such as the wind in my hair or the smells of things."];
      
    
    
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

- (IBAction)metricButtonPressed:(id)sender {
    
    if (self.paperFoldNavController.paperFoldView.state == FoldStateClosed && self.sleepArray.count > 0) {
        [self performSegueWithIdentifier:@"showMetric" sender:sender];
    }
    else {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    }
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
    return 0;
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

    if ([segue.identifier isEqualToString:@"showMetric"]) {
        SingleMetricTableViewController *singleMetricTableViewController = segue.destinationViewController;
        if ([sender isEqual:self.sleepButton]) {
            singleMetricTableViewController.ArrayOfValues = self.sleepArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initSleep];
        }
        else if ([sender isEqual:self.presenceButton]) {
            singleMetricTableViewController.ArrayOfValues = self.presenceArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initPresence];
        }
        else if ([sender isEqual:self.activityButton]) {
            singleMetricTableViewController.ArrayOfValues = self.activityArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initActivity];
        }
        else if ([sender isEqual:self.creativityButton]) {
            singleMetricTableViewController.ArrayOfValues = self.creativityArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initCreativity];
        }
        else if ([sender isEqual:self.eatingButton]) {
            singleMetricTableViewController.ArrayOfValues = self.eatingArray;
            singleMetricTableViewController.metricDaysArray = self.metricDaysArray;
            singleMetricTableViewController.metric = [[Metric alloc] initEating];
        }
    }

}



@end



















