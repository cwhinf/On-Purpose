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
    if ([name isEqualToString:@"Sleep"]) {
        self.slider.dataSource = self;
    }
}

- (void) setCellColor:(UIColor *) cellColor {
    
    //[self.buttons setColorsOuterColor:cellColor innerColor:[UIColor whiteColor]];
    //[self.assessmentButton setTitleColor:cellColor forState:UIControlStateNormal];
    [self.titleLabel setTextColor:cellColor];
    /*
    self.ratingView.circleColor = cellColor;
    self.ratingView.disableStateTextColor = [UIColor OPGreyTextColor];//cellColor;
    self.ratingView.selectedStateTextColor = cellColor;
    [self.ratingView drawSlider];
    */
    self.slider.popUpViewColor = cellColor;
    //[self.slider setPopUpViewAnimatedColors:@[[UIColor whiteColor], cellColor] withPositions:@[@0, @5]];
    
    
    CGRect sliderRect = CGRectMake(0.0, 0.0, 20.0, 20.0);
    CGPoint center = CGPointMake(sliderRect.size.width/2, sliderRect.size.height/2);
    UIGraphicsBeginImageContextWithOptions(sliderRect.size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetStrokeColorWithColor(context, cellColor.CGColor);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), sliderRect.size.width);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddLineToPoint(context, center.x, center.y);
    CGContextStrokePath(context);
    
    //[self.slider setMinimumTrackImage:self.slider.minimumValueImage forState:UIControlStateNormal];
    //[self.slider setMaximumTrackImage:self.slider.maximumTrackTintColor forState:UIControlStateNormal];
    [self.slider setThumbImage:UIGraphicsGetImageFromCurrentImageContext() forState:UIControlStateNormal];
    
    
}


- (void)awakeFromNib
{
    [self.titleLabel setFont:[UIFont mainFontWithSize:16]];
    [self.assessmentButton setFont:[UIFont mainFontWithSize:14]];
    
    
    
    // Initialization code
    /*
    self.buttons = [[CWRadioButtons alloc] init];
    
    [self.buttons setButtonsFonts:[UIFont mainFontWithSize:24]];
     */
    /*
    [self.buttons addButton:self.button1];
    [self.buttons addButton:self.button2];
    [self.buttons addButton:self.button3];
    [self.buttons addButton:self.button4];
    [self.buttons addButton:self.button5];
     */
    
    //TDRatingView *ratingView = [[TDRatingView alloc]init];
    /*
    self.ratingView = [[CWRatingView alloc]initWithFrame:CGRectMake(20.0f, 45.0f, 280.0f, 40.0f)];
    self.ratingView.delegate = self;
    self.ratingView.maximumRating = 5;
    self.ratingView.minimumRating = 1;
    self.ratingView.difference = 1;
    self.ratingView.font = [UIFont mainFontWithSize:20.0f];
    
    [self addSubview:self.ratingView];
     */
    
    self.slider.maximumValue = 5.0;
    self.slider.popUpViewCornerRadius = 5.0;
    self.slider.font = [UIFont mainFontWithSize:16];
    self.slider.textColor = [UIColor whiteColor];
    [self.slider setMaxFractionDigitsDisplayed:1];
    self.slider.delegate = self;
    
     /*
    self.slider.maximumValue = 255.0;
    self.slider.popUpViewCornerRadius = 0.0;
    [self.slider setMaxFractionDigitsDisplayed:0];
    self.slider.popUpViewColor = [UIColor colorWithHue:0.55 saturation:0.8 brightness:0.9 alpha:0.7];
    self.slider.font = [UIFont fontWithName:@"GillSans-Bold" size:22];
    self.slider.textColor = [UIColor colorWithHue:0.55 saturation:1.0 brightness:0.5 alpha:1];
      */
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setTableViewController:(DailySpaceTableViewController *)tableViewController {
    self.buttons.delegate = tableViewController;
}

#pragma - mark TDRatingViewDelegate

- (void) selectedRating:(NSString *)scale {
    
}

#pragma mark - ASValueTrackingSliderDelegate
- (void)sliderWillDisplayPopUpView:(ASValueTrackingSlider *)slider {
    
    
}

- (void)sliderWillHidePopUpView:(ASValueTrackingSlider *)slider{
    float closest = roundf(slider.value);
    [UIView animateWithDuration:.3 animations:^{
        [slider setValue:closest animated:YES];
    } completion:^(BOOL finished) {
        [slider hidePopUpView];
    }];
}

#pragma mark - ASValueTrackingSliderDataSource

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value;
{
    //value = roundf(value);
    NSString *s;
    if (value >= .9 && value < 1.1) {
        s = @"Nodding off";
    } else if (value >= 1.9 && value < 2.1) {
        s = @"I need a coffee";
    } else if (value >= 2.9 && value < 3.1) {
        s = @"I'll live";
    } else if (value >= 3.9 && value < 4.1) {
        s = @"Well rested";
    }
    return s;
}




@end















