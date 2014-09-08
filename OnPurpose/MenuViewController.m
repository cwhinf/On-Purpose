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
#import "UIFont+fonts.h"
#import "UIColor+colors.h"

@interface MenuViewController ()

- (IBAction)homePressed:(id)sender;
- (IBAction)forecastPressed:(id)sender;
- (IBAction)spacePressed:(id)sender;

@property (strong, nonatomic) UITabBarController *mainTabBarController;
@property (strong, nonatomic) UIImage *circleImage;


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
    
    UIFont *font = [UIFont mainFontBoldWithSize:20];
    [self.button1.titleLabel setFont:font];
    [self.button2.titleLabel setFont:font];
    [self.button3.titleLabel setFont:font];
    
    self.button1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.button2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.button3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:@"On Purpose"];
    [title addAttribute:NSFontAttributeName value:[UIFont mainFontLightWithSize:24] range:NSMakeRange(0, 2)];
    [title addAttribute:NSFontAttributeName value:[UIFont mainFontBoldWithSize:24] range:NSMakeRange(3, 7)];
    //self.menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 150)];
    [self.menuLabel setAttributedText:title];
    //[self.menuLabel setTextColor:[UIColor whiteColor]];
    //font = [UIFont mainFontBoldWithSize:24.0f];
    //[self.menuLabel setFont:font];
    
    /*
    CGRect rect = CGRectMake(0.0f, 0.0f, 100.0f, 100.0f);
    CGPoint center = CGPointMake(rect.size.width/2, rect.size.height/2);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddLineToPoint(context, center.x, center.y);
    
    //stroke outer circle
    CGContextSetLineWidth(context, 80.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextStrokePath(context);
    
    self.circleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self.button1 setBackgroundImage:self.circleImage forState:UIControlStateNormal];
    [self.button2 setBackgroundImage:self.circleImage forState:UIControlStateNormal];
    [self.button3 setBackgroundImage:self.circleImage forState:UIControlStateNormal];
    [self.button4 setBackgroundImage:self.circleImage forState:UIControlStateNormal];
    [self.button5 setBackgroundImage:self.circleImage forState:UIControlStateNormal];
    */
    
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
    
    [self.button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
}

- (IBAction)forecastPressed:(id)sender {
    
    [self.mainTabBarController setSelectedIndex:1];
    [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    
    [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
}

- (IBAction)spacePressed:(id)sender {
    
    [self.mainTabBarController setSelectedIndex:2];
    [self.paperFoldNavController.paperFoldView setPaperFoldState:PaperFoldStateDefault animated:YES];
    
    [self.button1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.button3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}



@end














