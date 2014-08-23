//
//  AssesmentStepViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Assessment.h"

@interface ScaledStepViewController : UIViewController


@property (strong, nonatomic) NSString *graphName;
@property (strong, nonatomic) UIColor *graphColor;

@property (strong, nonatomic) NSString *questionString;
@property NSInteger questionNumber;
@property NSInteger questionTotal;
@property Assessment *assessment;

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) IBOutlet UIButton *buttonOne;
@property (strong, nonatomic) IBOutlet UIButton *buttonTwo;
@property (strong, nonatomic) IBOutlet UIButton *buttonThree;
@property (strong, nonatomic) IBOutlet UIButton *buttonFour;
@property (strong, nonatomic) IBOutlet UIButton *buttonFive;

@property (strong, nonatomic) IBOutlet UILabel *scaleLabel1;
@property (strong, nonatomic) IBOutlet UILabel *scaleLabel2;



@property (strong, nonatomic) IBOutlet UIButton *buttonA;
@property (strong, nonatomic) IBOutlet UIButton *buttonB;
@property (strong, nonatomic) IBOutlet UIButton *buttonC;
@property (strong, nonatomic) IBOutlet UIButton *buttonD;
@property (strong, nonatomic) IBOutlet UIButton *buttonE;
@property (strong, nonatomic) IBOutlet UIButton *buttonA2;
@property (strong, nonatomic) IBOutlet UIButton *buttonB2;
@property (strong, nonatomic) IBOutlet UIButton *buttonC2;
@property (strong, nonatomic) IBOutlet UIButton *buttonD2;
@property (strong, nonatomic) IBOutlet UIButton *buttonE2;


@property (strong, nonatomic) IBOutlet UIButton *buttonYes;
@property (strong, nonatomic) IBOutlet UIButton *buttonNo;


@property (strong, nonatomic) IBOutlet UILabel *choiceALabel;
@property (strong, nonatomic) IBOutlet UILabel *choiceBLabel;
@property (strong, nonatomic) IBOutlet UILabel *choiceCLabel;
@property (strong, nonatomic) IBOutlet UILabel *choiceDLabel;
@property (strong, nonatomic) IBOutlet UILabel *choiceELabel;



@property (strong, nonatomic) IBOutlet UIButton *nextButton;
@property (strong, nonatomic) IBOutlet UIImageView *nextArrow;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;





- (IBAction)scaleButtonPressed:(id)sender;





- (IBAction)nextPressed:(id)sender;

- (IBAction)previousPressed:(id)sender;


@end
