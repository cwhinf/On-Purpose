//
//  DailySpaceCell.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "DailySpaceCell.h"
#import "UIColor+colors.h"
#import "UIFont+fonts.h"


@implementation DailySpaceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
    }
    return self;
}


- (void) setCellName:(NSString *) name {
    [self.titleLabel setText:name];
}

- (void) setCellColor:(UIColor *) cellColor {
    [self.buttons setColorsOuterColor:cellColor innerColor:[UIColor whiteColor]];
    //[self.assessmentButton setTitleColor:cellColor forState:UIControlStateNormal];
    [self.titleLabel setTextColor:cellColor];
    
    self.ratingView.circleColor = cellColor;
    self.ratingView.disableStateTextColor = [UIColor OPGreyTextColor];//cellColor;
    self.ratingView.selectedStateTextColor = cellColor;
    [self.ratingView drawSlider];
}


- (void)awakeFromNib
{
    [self.titleLabel setFont:[UIFont mainFontWithSize:24]];
    [self.assessmentButton setFont:[UIFont mainFontWithSize:15]];
    
    
    
    // Initialization code
    self.buttons = [[CWRadioButtons alloc] init];
    
    [self.buttons setButtonsFonts:[UIFont mainFontWithSize:24]];
    /*
    [self.buttons addButton:self.button1];
    [self.buttons addButton:self.button2];
    [self.buttons addButton:self.button3];
    [self.buttons addButton:self.button4];
    [self.buttons addButton:self.button5];
     */
    
    //TDRatingView *ratingView = [[TDRatingView alloc]init];
    self.ratingView = [[TDRatingView alloc]initWithFrame:CGRectMake(20.0f, 45.0f, 280.0f, 40.0f)];
    self.ratingView.delegate = self;
    self.ratingView.maximumRating = 5;
    self.ratingView.minimumRating = 1;
    self.ratingView.difference = 1;
    self.ratingView.font = [UIFont mainFontWithSize:20.0f];
    
    [self addSubview:self.ratingView];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTableViewController:(DailySpaceTableViewController *)tableViewController {
    self.buttons.delegate = tableViewController;
}

#pragma TDRatingViewDelegate

- (void) selectedRating:(NSString *)scale {
    
}



@end















