//
//  SingleMetricDayCell.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/6/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "SingleMetricDayCell.h"
#import "UIFont+fonts.h"

@implementation SingleMetricDayCell

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
    [self.dayLabel setFont:[UIFont mainFontLightWithSize:29.0f]];
    [self.expandedText setFont:[UIFont mainFontBoldWithSize:17.0f]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
