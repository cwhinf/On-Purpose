//
//  ForecastPopUpViewController.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Metric.h"

@interface ForecastPopUpViewController : UIViewController

@property (strong, nonatomic) NSNumber *average;
@property (strong, nonatomic) Metric *metric;

@property (strong, nonatomic) IBOutlet UILabel *aristotleLabel;
@property (strong, nonatomic) IBOutlet UILabel *forecastLabel;
@property (strong, nonatomic) IBOutlet UIButton *averageLabel;
@property (strong, nonatomic) IBOutlet UILabel *whyLabel;







- (void)averageForRadialView:(NSNumber *) average;

@end
