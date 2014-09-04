//
//  ForecastStepsController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "ForecastStepsController.h"
#import "ScaledStepViewController.h"
#import "UIFont+fonts.h"

@interface ForecastStepsController ()

@end

@implementation ForecastStepsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.stepsBar.hideCancelButton = YES;
    [self.stepsBar setHidden:YES];
    self.assessment.answers = [[NSMutableArray alloc] initWithCapacity:self.assessment.questions.count];
    for (int i=0; i < self.assessment.questions.count; i++) {
        [self.assessment.answers addObject:[NSNumber numberWithInt:0]];
    }
    
    //set navController color and font
    self.navigationController.navigationBar.tintColor = self.assessment.graphColor;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:
                                       self.navigationController.navigationBar.titleTextAttributes];
    [attributes setObject:self.assessment.graphColor forKey:@"NSColor"];
    [attributes setObject:[UIFont mainFontWithSize:27] forKey:@"NSFont"];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
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
    
    ScaledStepViewController *step;
    
    NSInteger questionNumber = 1;
    NSInteger questionTotal= self.assessment.questions.count;
    
    for(NSString *question in self.assessment.questions) {
        
        step = [self.storyboard instantiateViewControllerWithIdentifier:@"assesmentStep"];
        //step.questionString = question;
        step.assessment = self.assessment;
        step.step.title = @"";
        step.graphName = self.assessment.graphName;
        step.graphColor = self.assessment.graphColor;
        step.questionNumber = questionNumber;
        step.questionTotal = questionTotal;
        [steps addObject:step];
        
        questionNumber++;
    }


    return steps;
}

- (void)finishedAllSteps {
    [self.delegate stepsControllerdidFinishSteps:self];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)canceled {
    [self.navigationController popViewControllerAnimated:YES];
}

@end























