//
//  MetricTableViewCell.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "MetricTableViewCell.h"
#import "MDRadialProgressTheme.h"


@implementation MetricTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    
    [self.spaceLetterLabel setFont:[UIFont mainFontWithSize:68.0f]];
    [self.graphName setFont:[UIFont mainFontWithSize:17.0f]];
    [self.averageLabel setFont:[UIFont mainFontWithSize:20.0f]];
    
}

- (void) metricForCell:(Metric *)metric {
    self.metric = metric;
    [self.spaceLetterLabel setText:[metric.graphName substringToIndex:1]];
    [self.graphName setText:metric.graphName];
    
    if ([metric.type isEqualToString:@"SPACE"]) {
        [self.spaceLetterLabel setTextColor:metric.graphColor];
    }
    else {
        [self.spaceLetterLabel setTextColor:[UIColor clearColor]];
    }
    
    
    //[self.graphName setTextColor:metric.graphColor];
    //[self.averageLabel setTextColor:metric.graphColor];
    /*
    [self.label1 setTextColor:metric.graphColor];
    [self.label2 setTextColor:metric.graphColor];
    [self.label3 setTextColor:metric.graphColor];
    [self.label4 setTextColor:metric.graphColor];
    [self.label5 setTextColor:metric.graphColor];
     */
}

- (void) graphValues:(NSArray *)values dates:(NSArray *)dates {
    self.ArrayOfValues = values;
    self.ArrayOfDates = dates;
    
    self.graph.colorTop = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0];
    self.graph.colorBottom = [UIColor clearColor];//[UIColor colorWithRed:31.0/255.0 green:187.0/255.0 blue:166.0/255.0 alpha:1.0]; // Leaving this not-set on iOS 7 will default to your window's tintColor
    self.graph.colorLine = self.metric.graphColor;
    self.graph.colorXaxisLabel = [UIColor OPGreyTextColor];
    self.graph.widthLine = 3.0;
    self.graph.enableTouchReport = YES;
    self.graph.enablePopUpReport = YES;
    self.graph.enableBezierCurve = YES;
    //self.graph.min = graphMin;
    //self.sleepGraph.max = graphMax;
    [self.graph reloadGraph];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];
    
    MDRadialProgressTheme *theme = [[MDRadialProgressTheme alloc] init];
    theme.sliceDividerHidden = YES;
    theme.completedColor = self.metric.graphColor;
    theme.incompletedColor = [self.metric.graphColor colorWithAlphaComponent:.5];
    theme.labelColor = [UIColor clearColor];
    
    self.average = [self.ArrayOfValues valueForKeyPath:@"@avg.self"];
    [self.averageLabel setText:[formatter stringFromNumber:self.average]];
    if (self.radialView) {
        [self.radialView setHidden:YES];
        [self.radialView removeFromSuperview];
    }
    
    self.radialView = [[MDRadialProgressView alloc] initWithFrame:self.averageLabel.frame andTheme:theme];
    self.radialView.progressTotal = 500;
    self.radialView.progressCounter = 0;
    [self addSubview:self.radialView];
    [self radialView:self.radialView incrementAverage:self.average];
    
    
    
    
    
}


- (void) refreshAnimations {
    
    self.radialView.progressCounter = 0;
    [self radialView:self.radialView incrementAverage:self.average];
    [self.graph reloadGraph];
    
    
    
}


- (void) radialView:(MDRadialProgressView *) radialView incrementAverage:(NSNumber *) average{
    
    if (radialView.progressCounter < [average floatValue] * 100) {
        radialView.progressCounter = radialView.progressCounter + 5;
        if (radialView.progressCounter >= [average floatValue] * 100) {
            radialView.progressCounter = [average floatValue] * 100;
        }
        else {
            double delayInSeconds = .02;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //code to be executed on the main queue after delay
                [self radialView:radialView incrementAverage:average];
            });
        }
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
