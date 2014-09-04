//
//  Metric.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "Metric.h"


@implementation Metric


- (id)initSleep {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"SPACE";
        self.graphName = @"Sleep";
        self.graphColor = [UIColor OPRedColor];
        self.graphDefinition = @"is a rating on how well you slept. It can be based on hours or anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initPresence {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"SPACE";
        self.graphName = @"Presence";
        self.graphColor = [UIColor OPBlueColor];
        self.graphDefinition = @"is a rating on how present you are. It can be based on anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initActivity {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"SPACE";
        self.graphName = @"Activity";
        self.graphColor = [UIColor OPYellowColor];
        self.graphDefinition = @"is a rating on how active you are. It can be based on hours or anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initCreativity {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"SPACE";
        self.graphName = @"Creativity";
        self.graphColor = [UIColor OPAquaColor];
        self.graphDefinition = @"is a rating on how creative you are. It can be based on anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initEating {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"SPACE";
        self.graphName = @"Eating";
        self.graphColor = [UIColor OPOrangeColor];
        self.graphDefinition = @"is a rating on how well you ate. It can be based on food or anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initEnergy {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"nonSPACE";
        self.graphName = @"Energy";
        self.graphColor = [UIColor OPYellowColor];
        self.graphDefinition = @"is a rating on how energetic you are. It can be based on anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initSelfControl {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"nonSPACE";
        self.graphName = @"Self Control";
        self.graphColor = [UIColor OPAquaColor];
        self.graphDefinition = @"is a rating on how in control you are. It can be based on anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}

- (id)initVitality {
    self = [super init];
    if (self) {
        // Initialization code
        self.type = @"nonSPACE";
        self.graphName = @"Vitality";
        self.graphColor = [UIColor OPOrangeColor];
        self.graphDefinition = @"is a rating on your vitality. It can be based on or anything";
        self.assessment = [[Assessment alloc] init];
    }
    return self;
}


@end



















