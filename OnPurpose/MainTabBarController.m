//
//  PaperFoldTabBarController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/11/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "MainTabBarController.h"
#import "Constants.h"

@interface MainTabBarController ()

@property (strong, nonatomic) RNFrostedSidebar *frostedSidebar;

@end

@implementation MainTabBarController

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
    
    CGRect titleFrame = CGRectMake(0.0, 0.0, 80.0, 80.0);
    UIGraphicsBeginImageContextWithOptions(titleFrame.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    [titleLabel setText:@"Dashboard"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor OPGreyTextColor]];
    [titleLabel setFont:[UIFont mainFontWithSize:14.0]];
    [titleLabel.layer drawInContext:context];
    UIImage *dashboardImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContextWithOptions(titleFrame.size, NO, 0.0);
    context = UIGraphicsGetCurrentContext();
    titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    [titleLabel setText:@"Forecast"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor OPGreyTextColor]];
    [titleLabel setFont:[UIFont mainFontWithSize:20.0]];
    [titleLabel.layer drawInContext:context];
    UIImage *forecastImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    UIGraphicsBeginImageContextWithOptions(titleFrame.size, NO, 0.0);
    context = UIGraphicsGetCurrentContext();
    titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    [titleLabel setText:@"Daily Values"];
    [titleLabel setNumberOfLines:2];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor OPGreyTextColor]];
    [titleLabel setFont:[UIFont mainFontWithSize:20.0]];
    [titleLabel.layer drawInContext:context];
    UIImage *dailyValuesImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    NSArray *images = @[
                        [UIImage imageNamed:@"dashboard.png"],
                        [UIImage imageNamed:@"appbar.weather.overcast.png"],
                        [UIImage imageNamed:@"appbar.scale.unbalanced.png"],
                        [UIImage imageNamed:@"appbar.group.png"],
                        [[UIImage alloc] init]
                        ];
    NSArray *colors = @[
                        [UIColor OPRedColor],
                        [UIColor OPBlueColor],
                        [UIColor OPYellowColor],
                        [UIColor OPAquaColor],
                        [UIColor clearColor]
                        ];
    
    NSMutableIndexSet *optionIndices = [NSMutableIndexSet indexSetWithIndex:0];
    
    self.frostedSidebar = [[RNFrostedSidebar alloc] initWithImages:images selectedIndices:optionIndices borderColors:colors];
    self.frostedSidebar.itemBackgroundColor = [UIColor clearColor];
    self.frostedSidebar.itemSize = CGSizeMake(100.0, 100.0);
    self.frostedSidebar.borderWidth = 5.0f;
    self.frostedSidebar.tintColor = [[UIColor blackColor] colorWithAlphaComponent:.2];
    self.frostedSidebar.isSingleSelect = YES;
    self.frostedSidebar.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showMenu {
    [self.frostedSidebar show];

}

- (void)hideMenu {
    [self.frostedSidebar dismissAnimated:YES];
}

#pragma mark - RNFrostedSidebarDelegate

- (void)sidebar:(RNFrostedSidebar *)sidebar didTapItemAtIndex:(NSUInteger)index {
    
    if (index < 2) {
        [self setSelectedIndex:index];
    }
    
    [self.frostedSidebar dismissAnimated:YES];
    
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
