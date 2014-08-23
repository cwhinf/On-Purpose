//
//  AssesmentStepViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ScaledStepViewController.h"
#import "RMStepsController.h"
#import "ScaledStepViewController.h"
#import "ScoreViewController.h"

@interface ScaledStepViewController () {
    CGRect nextButtonFrame;
    CGRect nextArrowFrame;
}

@property (strong, nonatomic) UIImage *unselectedButtonImage;
@property (strong, nonatomic) UIImage *selectedButtonImage;
@property (strong, nonatomic) NSArray *roundButtons;
@property (strong, nonatomic) NSArray *multipleButtons;
@property (strong, nonatomic) NSArray *multipleButtons2;
@property (strong, nonatomic) NSArray *multipleChoices;

@property (strong, nonatomic) UIButton *selectedButton;

@end

@implementation ScaledStepViewController

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
    self.roundButtons = @[self.buttonOne, self.buttonTwo, self.buttonThree, self.buttonFour, self.buttonFive, self.buttonA, self.buttonB, self.buttonC, self.buttonD, self.buttonE];
    self.multipleButtons = @[self.buttonA, self.buttonB, self.buttonC, self.buttonD, self.buttonE];
    self.multipleButtons2 = @[self.buttonA2, self.buttonB2, self.buttonC2, self.buttonD2, self.buttonE2];
    self.multipleChoices = @[self.choiceALabel, self.choiceBLabel, self.choiceCLabel, self.choiceDLabel, self.choiceELabel];
    
    [self.questionLabel setText:[self.assessment.questions objectAtIndex:self.questionNumber - 1]];
    
    if ([[self.assessment.questionTypes objectAtIndex:self.questionNumber - 1] isEqualToString:QuestionTypeMultiple]) {
        [self hideScaleAnswers];
        [self hideYesNoAnswers];
        
        NSArray *choices = [self.assessment.questionChoices objectForKey:[@(self.questionNumber) stringValue]];
        
        for (int i=0; i < self.multipleButtons.count; i++) {
            if (i < choices.count) {
                [((UILabel *)[self.multipleChoices objectAtIndex:i]) setText:[choices objectAtIndex:i]];
            }
            else {
                [[self.multipleButtons objectAtIndex:i] setHidden:YES];
                [[self.multipleButtons2 objectAtIndex:i] setHidden:YES];
                [[self.multipleChoices objectAtIndex:i] setHidden:YES];
            }
        }
        
    }
    else if ([[self.assessment.questionTypes objectAtIndex:self.questionNumber - 1] isEqualToString:QuestionTypeScale]) {
        [self hideMultipleAnswers];
        [self hideYesNoAnswers];
    }
    else if ([[self.assessment.questionTypes objectAtIndex:self.questionNumber - 1] isEqualToString:QuestionTypeYesNo]) {
        [self hideMultipleAnswers];
        [self hideScaleAnswers];
    }
    
    
    nextButtonFrame = CGRectMake(105.0f, 480.0f, 190.0f, 60.0f);
    nextArrowFrame = CGRectMake(265.0f, 490.0f, 50.0f, 50.0f);
    
    
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
    
    for (UIButton *button in self.roundButtons) {
        [button setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    }
    [self.buttonYes.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:60]];
    [self.buttonNo.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:60]];
    
    
    [self.nextButton.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:68]];
    [self.previousButton.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:19]];
    /*
    [self.buttonOne.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonTwo.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonThree.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonFour.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonFive.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonA.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonB.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonC.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonD.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonE.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:24]];
    [self.buttonYes.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:36]];
    [self.buttonNo.titleLabel setFont:[UIFont fontWithName:@"Museo-500" size:36]];
    */
    
    [self unselectAllScaleButtons];
    
    [self.parentViewController.navigationItem setTitle:[NSString stringWithFormat:@"%@/%@", [@(self.questionNumber) stringValue], [@(self.questionTotal) stringValue]]];
    
}

- (void) viewDidAppear:(BOOL)animated {
    
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
    self.selectedButton = (UIButton *)sender;
    
    if ([self.multipleButtons2 containsObject:self.selectedButton]) {
        self.selectedButton = [self.multipleButtons objectAtIndex:[self.multipleButtons2 indexOfObject:self.selectedButton]];
    }
    
    if ([self.roundButtons containsObject:self.selectedButton]) {
        [self.selectedButton setBackgroundImage:self.selectedButtonImage forState:UIControlStateNormal];
        [self.selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else {
        [self.selectedButton setTitleColor:self.graphColor forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.65f animations:^{
        self.nextButton.frame = nextButtonFrame;
        self.nextArrow.frame = nextArrowFrame;
    } completion:^(BOOL finished) {
        
    }];

}

- (IBAction)nextPressed:(id)sender {
    
    
    if (self.questionNumber == self.questionTotal) {
        [self.assessment.answers addObject:[NSNumber numberWithInt:self.selectedButton.tag]];
        [self.stepsController showNextStep];
        [self performSegueWithIdentifier:@"showScore" sender:self];
    }
    else {
        [self.assessment.answers addObject:[NSNumber numberWithInt:self.selectedButton.tag]];
        [self.stepsController showNextStep];
    }
}

- (IBAction)previousPressed:(id)sender {
    [self.stepsController showPreviousStep];
}


- (void) unselectAllScaleButtons {
    
    
    for (UIButton *button in self.roundButtons) {
        [button setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
        [button setTitleColor:self.graphColor forState:UIControlStateNormal];
    }
    [self.buttonYes setTitleColor:[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    [self.buttonNo setTitleColor:[UIColor colorWithRed:130.0f/255.0f green:130.0f/255.0f blue:130.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    /*
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
    */
   
}

- (void) hideMultipleAnswers {
    
    for (UIButton *button in self.multipleButtons) {
        [button setHidden:YES];
    }
    for (UIButton *button in self.multipleButtons2) {
        [button setHidden:YES];
    }
    for (UILabel *label in self.multipleChoices) {
        [label setHidden:YES];
    }
}

- (void) hideScaleAnswers {
    [self.buttonOne setHidden:YES];
    [self.buttonTwo setHidden:YES];
    [self.buttonThree setHidden:YES];
    [self.buttonFour setHidden:YES];
    [self.buttonFive setHidden:YES];
}

- (void) hideYesNoAnswers {
    [self.buttonYes setHidden:YES];
    [self.buttonNo setHidden:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"showScore"]) {
        UINavigationController *navController = segue.destinationViewController;
        ScoreViewController *scoreViewController = navController.topViewController;
        scoreViewController.assesment = self.assessment;
        scoreViewController.graphName = self.graphName;
        scoreViewController.graphColor = self.graphColor;
    }
    
    
}









@end











