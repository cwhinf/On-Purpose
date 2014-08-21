//
//  ForecastStepsController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ForecastStepsController.h"
#import "AssesmentStepViewController.h"

@interface ForecastStepsController ()

@end

@implementation ForecastStepsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepsBar.hideCancelButton = YES;
}

- (NSArray *)stepViewControllers {
    /*
    AssesmentStepViewController *firstStep = [self.storyboard instantiateViewControllerWithIdentifier:@"assesmentStep"];
    firstStep.questionString =  @"This is the first question?";
    firstStep.step.title = @"First";
    firstStep.graphColor = self.graphColor;
    
    AssesmentStepViewController *secondStep = [self.storyboard instantiateViewControllerWithIdentifier:@"assesmentStep"];
    secondStep.questionString = @"This is the second question?";
    secondStep.step.title = @"Second";
    secondStep.graphColor = self.graphColor;
*/
    NSMutableArray *steps = [[NSMutableArray alloc] init];
    
    AssesmentStepViewController *step;
    
    for(NSString *question in self.assesment) {
        
        step = [self.storyboard instantiateViewControllerWithIdentifier:@"assesmentStep"];
        step.questionString = question;
        step.step.title = @"";
        step.graphColor = self.graphColor;
        [steps addObject:step];
        
    }


    return steps;
}

- (void)finishedAllSteps {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
