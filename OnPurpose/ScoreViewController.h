//
//  ScoreViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/22/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Assessment.h"

@interface ScoreViewController : UIViewController

@property (strong, nonatomic) NSString *graphName;
@property (strong, nonatomic) UIColor *graphColor;


@property (strong, nonatomic) NSNumber *score;

@property (strong, nonatomic) IBOutlet UIButton *scoreValueLabel;
@property (strong, nonatomic) IBOutlet UIButton *finishButton;


- (IBAction)finishPressed:(id)sender;


@end
