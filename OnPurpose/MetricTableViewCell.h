//
//  MetricTableViewCell.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Metric.h"
#import "BEMSimpleLineGraphView.h"
#import "MDRadialProgressView.h"

@interface MetricTableViewCell : UITableViewCell <BEMSimpleLineGraphDelegate>


@property (strong, nonatomic) Metric *metric;
@property (strong, nonatomic) NSArray *ArrayOfValues;
@property (strong, nonatomic) NSArray *ArrayOfDates;
@property (strong, nonatomic) NSNumber *average;


@property (strong, nonatomic) IBOutlet UILabel *spaceLetterLabel;

@property (strong, nonatomic) IBOutlet UILabel *graphName;
@property (strong, nonatomic) IBOutlet UILabel *averageLabel;

@property (strong, nonatomic) IBOutlet UILabel *label1;
@property (strong, nonatomic) IBOutlet UILabel *label2;
@property (strong, nonatomic) IBOutlet UILabel *label3;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;

@property (weak, nonatomic) IBOutlet BEMSimpleLineGraphView *graph;

@property (strong, nonatomic) MDRadialProgressView *radialView;

- (void) metricForCell:(Metric *)metric;
- (void) graphValues:(NSArray *)values dates:(NSArray *)dates;
- (void) refreshAnimations;


@end
