//
//  ForecastStepsController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/20/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "RMStepsController.h"
#import "Assessment.h"

@interface ForecastStepsController : RMStepsController

@property (strong, nonatomic) Assessment *assessment;

@property (nonatomic) BOOL fullscreen;

@end
