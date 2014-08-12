//
//  MenuViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/11/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "MenuViewController.h"
#import "MetricsViewController.h";
#import "ForecastViewController.h"

@interface MenuViewController ()

- (IBAction)homePressed:(id)sender;
- (IBAction)forecastPressed:(id)sender;

@property (strong, nonatomic) UITabBarController *mainTabBarController;


@end

@implementation MenuViewController

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
    self.mainTabBarController = (UITabBarController *) self.paperFoldNavController.rootViewController;
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

- (IBAction)homePressed:(id)sender {
    
    [self.mainTabBarController setSelectedIndex:0];
    [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    
}

- (IBAction)forecastPressed:(id)sender {
    
    [self.mainTabBarController setSelectedIndex:1];
    [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
}



@end














