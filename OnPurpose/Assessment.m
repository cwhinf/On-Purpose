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
    }
    return self;
}


- (void) addMultipleQuestion:(NSString *) question Choices:(NSArray *) choices {
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeMultiple];
    [self.questionChoices setObject:choices forKey:[@(self.questions.count) stringValue]];
    
}

- (void) addScaleQuestion:(NSString *) question {
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeScale];
    
}

- (void) addYesNoQuestion:(NSString *) question {
    [self.questions addObject:question];
    [self.questionTypes addObject:QuestionTypeYesNo];
}



@end
