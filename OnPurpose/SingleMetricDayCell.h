//
//  SingleMetricDayCell.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/6/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleMetricDayCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UILabel *valueLabel;
@property (strong, nonatomic) IBOutlet UIImageView *expandArrow;
@property (strong, nonatomic) IBOutlet UILabel *expandedText;



@end
