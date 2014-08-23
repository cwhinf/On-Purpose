//
//  Assesment.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/22/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const QuestionTypeMultiple;
extern NSString *const QuestionTypeScale;
extern NSString *const QuestionTypeYesNo;

@interface Assessment : NSObject


@property (strong, nonatomic) NSMutableArray* questions;
@property (strong, nonatomic) NSMutableArray* questionTypes;
@property (strong, nonatomic) NSMutableDictionary* questionChoices;
@property (strong, nonatomic) NSMutableArray* answers;

- (void) addMultipleQuestion:(NSString *) question Choices:(NSArray *) choices;
- (void) addScaleQuestion:(NSString *) question;
- (void) addYesNoQuestion:(NSString *) question;

@end
