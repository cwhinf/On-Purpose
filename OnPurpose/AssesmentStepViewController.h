//
//  AssesmentStepViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssesmentStepViewController : UIViewController


@property (strong, nonatomic) UIColor *graphColor;

@property (strong, nonatomic) NSString *questionString;

@property (strong, nonatomic) IBOutlet UILabel *questionLabel;

@property (strong, nonatomic) IBOutlet UIButton *buttonOne;
@property (strong, nonatomic) IBOutlet UIButton *buttonTwo;
@property (strong, nonatomic) IBOutlet UIButton *buttonThree;
@property (strong, nonatomic) IBOutlet UIButton *buttonFour;
@property (strong, nonatomic) IBOutlet UIButton *buttonFive;


- (IBAction)scaleButtonPressed:(id)sender;





- (IBAction)nextPressed:(id)sender;

- (IBAction)previousPressed:(id)sender;


@end
