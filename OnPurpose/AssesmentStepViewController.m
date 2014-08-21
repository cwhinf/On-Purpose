//
//  AssesmentStepViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "AssesmentStepViewController.h"
#import "RMStepsController.h"
#import "AssesmentStepViewController.h"

@interface AssesmentStepViewController ()

@property (strong, nonatomic) UIImage *unselectedButtonImage;
@property (strong, nonatomic) UIImage *selectedButtonImage;

@end

@implementation AssesmentStepViewController

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
    [self.questionLabel setText:self.questionString];
    
    
    CGPoint center = CGPointMake(self.buttonOne.frame.size.width/2, self.buttonOne.frame.size.height/2);
    
    //UIGraphicsBeginImageContext(self.buttonOne.frame.size);
    UIGraphicsBeginImageContextWithOptions(self.buttonOne.frame.size, NO, 0.0f);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    
    //stroke outer circle
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.buttonOne.frame.size.width);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.graphColor.CGColor);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.selectedButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //stroke inner circle
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), self.buttonOne.frame.size.width - 5.0f);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [UIColor whiteColor].CGColor);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.unselectedButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    
    [self.buttonOne.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonTwo.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonThree.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonFour.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonFive.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    
    
    [self unselectAllScaleButtons];
    
    
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

- (IBAction)scaleButtonPressed:(id)sender {
    
    [self unselectAllScaleButtons];
    
    UIButton *selectedButton = (UIButton *)sender;
    
    [selectedButton setBackgroundImage:self.selectedButtonImage forState:UIControlStateNormal];
    [selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
}

- (IBAction)nextPressed:(id)sender {
    [self.stepsController showNextStep];
}

- (IBAction)previousPressed:(id)sender {
    [self.stepsController showPreviousStep];
}


- (void) unselectAllScaleButtons {
    [self.buttonOne setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
    [self.buttonOne setTitleColor:self.graphColor forState:UIControlStateNormal];
    
    [self.buttonTwo setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
    [self.buttonTwo setTitleColor:self.graphColor forState:UIControlStateNormal];
    
    [self.buttonThree setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
    [self.buttonThree setTitleColor:self.graphColor forState:UIControlStateNormal];
    
    [self.buttonFour setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
    [self.buttonFour setTitleColor:self.graphColor forState:UIControlStateNormal];
    
    [self.buttonFive setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
    [self.buttonFive setTitleColor:self.graphColor forState:UIControlStateNormal];
}









@end











