//
//  SingleMetricHeaderTableViewCell.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/5/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Parse/Parse.h>

#import "BEMSimpleLineGraphView.h"
#import "StatsViewController.h"

@interface SingleMetricHeaderTableViewCell : UITableViewCell 

@property (strong, nonatomic) NSMutableArray *ArrayOfValues;
@property (strong, nonatomic) NSMutableArray *ArrayOfDates;
@property (strong, nonatomic) UIColor *graphColor;
@property (strong, nonatomic) NSString *graphName;

@property (strong, nonatomic) IBOutlet UIView *singleMetricViewContainer;

@end
