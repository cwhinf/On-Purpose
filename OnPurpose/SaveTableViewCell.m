//
//  SaveTableViewCell.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "SaveTableViewCell.h"

@implementation SaveTableViewCell

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
