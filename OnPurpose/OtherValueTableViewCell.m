//
//  OtherValueTableViewCell.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/16/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "OtherValueTableViewCell.h"
#import "MDRadialProgressTheme.h"
#import "Constants.h"

#define NUMBEROFVALUES 3

@implementation OtherValueTableViewCell

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
    self.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (selected) {
    }
}


/*
- (IBAction)buttonPressed:(id)sender {
    
    if (self.greyView) {
        [self.greyView removeFromSuperview];
        self.greyView = nil;
    }
    else {
        if ([sender isEqual:self.button1]) {
            self.greyView = [[UIView alloc] initWithFrame:CGRectMake(107.0, 0.0, 213.0, self.frame.size.height)];
            [self.greyView setBackgroundColor:[[UIColor OPGreyTextColor] colorWithAlphaComponent:0.5]];
            [self addSubview:self.greyView];
        }
        else if ([sender isEqual:self.button2]) {
            self.greyView = [[UIView alloc] initWithFrame:self.frame];

            UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 107.0, self.frame.size.height)];
            [view1 setBackgroundColor:[[UIColor OPGreyTextColor] colorWithAlphaComponent:0.5]];
            [self.greyView addSubview:view1];
            
            UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 107.0, self.frame.size.height)];
            [view2 setBackgroundColor:[[UIColor OPGreyTextColor] colorWithAlphaComponent:0.5]];
            [self.greyView addSubview:view2];
            
            [self addSubview:self.greyView];
        }
        else if ([sender isEqual:self.button3]) {
            self.greyView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 213.0, self.frame.size.height)];
            [self.greyView setBackgroundColor:[[UIColor OPGreyTextColor] colorWithAlphaComponent:0.5]];
            [self addSubview:self.greyView];
        }
        
        
    }
}
 */

-(void) setAveragesOne:(NSNumber *) one Two:(NSNumber *) two Three:(NSNumber *) three {
    
    self.average1 = one;
    self.average2 = two;
    self.average3 = three;
    self.averages = @[self.average1, self.average2, self.average3];
    self.averageLabels = @[self.averageLabel1, self.averageLabel2, self.averageLabel3];
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setMaximumFractionDigits:1];
    [formatter setMinimumFractionDigits:1];

    for (int i=0; i < self.averageLabels.count; i++) {
        [[self.averageLabels objectAtIndex:i] setText:[formatter stringFromNumber:[self.averages objectAtIndex:i]]];
    }
    
    if (self.radialView1) {
        [self.radialView1 setHidden:YES];
        [self.radialView1 removeFromSuperview];
    }
    
    if (self.radialView2) {
        [self.radialView2 setHidden:YES];
        [self.radialView2 removeFromSuperview];
    }
    
    [self.averageLabel3 setText:[formatter stringFromNumber:self.average3]];
    if (self.radialView3) {
        [self.radialView3 setHidden:YES];
        [self.radialView3 removeFromSuperview];
    }
    
    

    
    self.unselectedTheme = [[MDRadialProgressTheme alloc] init];
    self.unselectedTheme.sliceDividerHidden = YES;
    self.unselectedTheme.completedColor = [UIColor OPGreyTextColor];
    self.unselectedTheme.incompletedColor = [[UIColor OPGreyTextColor] colorWithAlphaComponent:.5];
    self.unselectedTheme.labelColor = [UIColor clearColor];
    self.unselectedTheme.thickness = 10.0;
    
    
    self.selectedTheme = [[MDRadialProgressTheme alloc] init];
    self.selectedTheme.sliceDividerHidden = YES;
    self.selectedTheme.completedColor = [UIColor OPPurpleColor];
    self.selectedTheme.incompletedColor = [[UIColor OPPurpleColor] colorWithAlphaComponent:.5];
    self.selectedTheme.labelColor = [UIColor clearColor];
    self.selectedTheme.thickness = 10.0;
    
    
    
    self.radialView1 = [[MDRadialProgressView alloc] initWithFrame:self.averageLabel1.frame andTheme:self.unselectedTheme];
    self.radialView1.progressTotal = 500;
    self.radialView1.progressCounter = 0;
    [self addSubview:self.radialView1];
    [self sendSubviewToBack:self.radialView1];
    [self radialView:self.radialView1 incrementAverage:self.average1];
    
    self.radialView2 = [[MDRadialProgressView alloc] initWithFrame:self.averageLabel2.frame andTheme:self.unselectedTheme];
    self.radialView2.progressTotal = 500;
    self.radialView2.progressCounter = 0;
    [self addSubview:self.radialView2];
    [self sendSubviewToBack:self.radialView2];
    [self radialView:self.radialView2 incrementAverage:self.average2];
    
    self.radialView3 = [[MDRadialProgressView alloc] initWithFrame:self.averageLabel3.frame andTheme:self.unselectedTheme];
    self.radialView3.progressTotal = 500;
    self.radialView3.progressCounter = 0;
    [self addSubview:self.radialView3];
    [self sendSubviewToBack:self.radialView3];
    [self radialView:self.radialView3 incrementAverage:self.average3];
    self.radialViews = @[self.radialView1, self.radialView2, self.radialView3];

    if (self.greyView) {
        //self.greyView = [[UIView alloc] initWithFrame:CGRectMake(107.0, 0.0, 213.0, self.frame.size.height)];
        //self.greyView.frame = CGRectMake(107.0, 0.0, 213.0, self.frame.size.height);
        //[self.greyView setBackgroundColor:[UIColor OPGreyTextColor]];
        [self addSubview:self.greyView];
    }
    
}

-(void) selectIndex:(NSInteger) index {
    if (index >= 0 && index < NUMBEROFVALUES) {
        [[self.radialViews objectAtIndex:index] setTheme:self.selectedTheme];
    }
    else {
        for (MDRadialProgressView *radialView in self.radialViews) {
            [radialView setTheme:self.unselectedTheme];
        }
    }
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




@end



















