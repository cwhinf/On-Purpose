//
//  ChartPopViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/19/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ChartPopViewController.h"
#import "Constants.h"
#import "UIViewController+CWPopup.h"

@interface ChartPopViewController ()

@property (strong, nonatomic) UINavigationController *childNavController;

@end

@implementation ChartPopViewController

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
    [self.chartLabel setFont:[UIFont mainFontWithSize:22]];
    self.view.layer.cornerRadius = 10.0;
    self.view.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)showAssessment {
    [self.bottomButton setTitle:@"back" forState:UIControlStateNormal];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showDailySpaceNav"]) {
        self.childNavController = segue.destinationViewController;
    }
    
}


- (IBAction)closePressed:(id)sender {
    
    [self.parentViewController dismissPopupViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)bottomButtonPressed:(id)sender {
    
    [self.childNavController popToRootViewControllerAnimated:YES];
    [self.bottomButton setTitle:@"save" forState:UIControlStateNormal];
    
}



@end











