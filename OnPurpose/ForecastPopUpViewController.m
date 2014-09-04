//
//  ForecastPopUpViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ForecastPopUpViewController.h"
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "UIFont+fonts.h"

@interface ForecastPopUpViewController ()

@property (strong, nonatomic) MDRadialProgressView *radialView;

@end

@implementation ForecastPopUpViewController

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
    // Do any additional setup after loading the view.
    
    [self.aristotleLabel setFont:[UIFont mainFontLightWithSize:28.0f]];
    [self.forecastLabel setFont:[UIFont mainFontBoldWithSize:23.0f]];
    [self.averageLabel setFont:[UIFont mainFontLightWithSize:44.0f]];
    [self.whyLabel setFont:[UIFont mainFontWithSize:18.0f]];
    
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.radialView.progressCounter = 0;
    [self radialView:self.radialView incrementAverage:self.average];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)averageForRadialView:(NSNumber *) average {
    self.average = average;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    
    //UIFont *font = [UIFont fontWithName:@"OpenSans-Regular" size:100];
    
    CGRect radialAverageRect;
    
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.sliceDividerHidden = YES;
    theme.completedColor = self.metric.graphColor;
    theme.incompletedColor = [self.metric.graphColor colorWithAlphaComponent:.5];
    theme.labelColor = [UIColor clearColor];
    
    [self.averageLabel setTitle:[formatter stringFromNumber:self.average] forState:UIControlStateNormal];
    //[self.averageLabel setFont:font];
    
    
    radialAverageRect = self.averageLabel.frame;
    self.radialView = [[MDRadialProgressView alloc] initWithFrame:radialAverageRect andTheme:theme];
    self.radialView.progressTotal = 500;
    self.radialView.progressCounter = 0;
    [self.view addSubview:self.radialView];
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
