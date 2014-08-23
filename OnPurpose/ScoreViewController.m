//
//  ScoreViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/22/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ScoreViewController.h"

#import "MDRadialProgressView.h"
#import "MDRadialProgressTheme.h"

@interface ScoreViewController ()

@property (strong, nonatomic) MDRadialProgressView *radialView;

@end

@implementation ScoreViewController

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
    
    
    [self.navigationItem setTitle:self.graphName];
    [self.scoreValueLabel setTitleColor:self.graphColor forState:UIControlStateNormal];
    
    
    [self.scoreValueLabel setFont:[UIFont fontWithName:@"Museo-500" size:68.0f]];
    [self.finishButton.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:38.0f]];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    
    [self.scoreValueLabel setTitle:[formatter stringFromNumber:self.score] forState:UIControlStateNormal];
    
    
    
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.sliceDividerHidden = YES;
    theme.completedColor = self.graphColor;
    theme.incompletedColor = [self.graphColor colorWithAlphaComponent:.5];
    theme.labelColor = [UIColor clearColor];
    
    //radialAverageRect = CGRectMake(50, 440, 100, 100);
    self.radialView = [[MDRadialProgressView alloc] initWithFrame:self.scoreValueLabel.frame andTheme:theme];
    self.radialView.progressTotal = 500;
    self.radialView.progressCounter = 1;
    [self.view addSubview:self.radialView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self radialView:self.radialView incrementAverage:self.score];
    
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:self.graphColor forKey:@"NSColor"];
    [attributes setObject:[UIFont fontWithName:@"Museo-500" size:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    
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

- (IBAction)finishPressed:(id)sender {
    
    //[self.navigationController.parentViewController.navigationController popToRootViewControllerAnimated:YES];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
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









@end
