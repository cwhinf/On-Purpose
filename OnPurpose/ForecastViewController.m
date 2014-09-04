//
//  ForecastViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/10/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ForecastViewController.h"
#import "PaperFoldNavigationController.h"
#import "PaperFoldTabBarController.h"
#import "JYRadarChart.h"

@interface ForecastViewController ()

@property (strong, nonatomic) PaperFoldNavigationController *paperFoldNavController;
@property (strong, nonatomic) JYRadarChart *radarChart;


- (IBAction)menuPressed:(id)sender;

@end

@implementation ForecastViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0] forKey:@"NSColor"];
    [attributes setObject:[UIFont fontWithName:@"Museo-500" size:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
    PaperFoldTabBarController *paperFoldTabBarController = self.navigationController.parentViewController;
    self.paperFoldNavController = paperFoldTabBarController.paperFoldNavController;
    
    [self showRadarChart];
}



- (void) showRadarChart {
    self.radarChart = [[JYRadarChart alloc] initWithFrame:CGRectMake(0, 65, 320, 320)];
    
	NSArray *a1 = @[@(5), @(4), @(5), @(4), @(5)];
	NSArray *a2 = @[@(4), @(5), @(3), @(4), @(2)];
	self.radarChart.dataSeries = @[a1, a2];
	self.radarChart.steps = 5;
	self.radarChart.showStepText = NO;
	self.radarChart.backgroundColor = [UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
	self.radarChart.r = 120;
	self.radarChart.minValue = 0;
	self.radarChart.maxValue = 5;
	self.radarChart.fillArea = NO;
    self.radarChart.drawPoints = YES;
	self.radarChart.colorOpacity = 1.0;
	self.radarChart.attributes = @[@"Sleep", @"Presence", @"Activity", @"Creativity", @"Eating"];
	self.radarChart.showLegend = NO;
	[self.radarChart setTitles:@[@"lastWeek", @"nextWeek"]];
	[self.radarChart setColors:@[[UIColor colorWithRed:123.0/255.0 green:174.0/255.0 blue:166.0/255.0 alpha:1.0], [UIColor whiteColor]]];
	[self.view addSubview:self.radarChart];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)menuPressed:(id)sender {
    if (self.paperFoldNavController.paperFoldView.state == PaperFoldStateLeftUnfolded) {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    } else {
        [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateLeftUnfolded animated:YES];
    }
}



@end











