//
//  Metric.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+colors.h"
#import "UIFont+fonts.h"
#import "Assessment.h"
#import "Constants.h"


@interface Metric : NSObject

- (id)initSleep;
- (id)initPresence;
- (id)initActivity;
- (id)initCreativity;
- (id)initEating;
- (id)initEnergy;
- (id)initSelfControl;
- (id)initVitality;


@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *graphName;
@property (strong, nonatomic) UIColor *graphColor;
@property (strong, nonatomic) NSString *graphDefinition;
@property (strong, nonatomic) Assessment *assessment;

@end
