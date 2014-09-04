//
//  Assesment.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/22/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "Assessment.h"

NSString *const QuestionTypeMultiple = @"multiple";
NSString *const QuestionTypeScale = @"scale";
NSString *const QuestionTypeYesNo = @"yesNo";

@implementation Assessment

- (id)init {
    
    if (self = [super init]) {
        self.questions = [[NSMutableArray alloc] init];
        self.questionTypes = [[NSMutableArray alloc] init];
        self.questionChoices = [[NSMutableDictionary alloc] init];
        self.answers = [[NSMutableArray alloc] init];
        self.pointsForAnswers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addMultipleQuestion:(NSString *) question Choices:(NSArray *) choices PointsForAnswers: (NSArray *)points {
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeMultiple];
    [self.questionChoices setObject:choices forKey:[@(self.questions.count) stringValue]];
    
    [self.pointsForAnswers addObject:points];
}

- (void) addScaleQuestion:(NSString *) question {
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeScale];
    
    [self.pointsForAnswers addObject:@[@0.2f, @0.4f, @0.6f, @0.8f, @1.0f]];
    
}

- (void) addYesNoQuestion:(NSString *) question {
    
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    
    
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeYesNo];
}

- (void) addYesNoQuestion:(NSString *) question Accept: (BOOL) answer {
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeYesNo];
    
    NSMutableArray *points = [[NSMutableArray alloc] init];
    if (answer) {
        [points addObject:[NSNumber numberWithInt:1]];
        [points addObject:[NSNumber numberWithInt:0]];
    }
    else {
        [points addObject:[NSNumber numberWithInt:0]];
        [points addObject:[NSNumber numberWithInt:1]];
    }
    
    [self.pointsForAnswers addObject:points];
    
}

- (NSNumber *) score {
    NSNumber *total = [NSNumber numberWithInt:0];
    
    for (NSInteger i=0; i < self.pointsForAnswers.count; i++) {
        NSArray * points = [self.pointsForAnswers objectAtIndex:i];
        
        float pointsForAnswer = [((NSNumber *)[points objectAtIndex:[((NSNumber *)[self.answers objectAtIndex:i]) intValue] - 1]) floatValue];
        total = [NSNumber numberWithFloat:[total floatValue] + pointsForAnswer];
    }

    return [NSNumber numberWithFloat:5*[total floatValue]/self.pointsForAnswers.count ];
    
    
}



@end















