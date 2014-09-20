//
//  OtherValueTableViewCell.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/16/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressView.h"

@interface OtherValueTableViewCell : UITableViewCell

@property (strong, nonatomic) NSNumber *average1;
@property (strong, nonatomic) NSNumber *average2;
@property (strong, nonatomic) NSNumber *average3;

@property (nonatomic) NSUInteger visableIndex;

@property (strong, nonatomic) IBOutlet UILabel *vitalityLabel;
@property (strong, nonatomic) IBOutlet UILabel *willpowerLabel;
@property (strong, nonatomic) IBOutlet UILabel *relaxationLabel;

@property (strong, nonatomic) IBOutlet UILabel *averageLabel1;
@property (strong, nonatomic) IBOutlet UILabel *averageLabel2;
@property (strong, nonatomic) IBOutlet UILabel *averageLabel3;

@property (strong, nonatomic) IBOutlet UIButton *button1;
@property (strong, nonatomic) IBOutlet UIButton *button2;
@property (strong, nonatomic) IBOutlet UIButton *button3;

@property (strong, nonatomic) MDRadialProgressTheme *selectedTheme;
@property (strong, nonatomic) MDRadialProgressTheme *unselectedTheme;

@property (strong, nonatomic) MDRadialProgressView *radialView1;
@property (strong, nonatomic) MDRadialProgressView *radialView2;
@property (strong, nonatomic) MDRadialProgressView *radialView3;


@property (strong, nonatomic) NSArray *averages;
@property (strong, nonatomic) NSArray *valueLabels;
@property (strong, nonatomic) NSArray *averageLabels;
@property (strong, nonatomic) NSArray *radialViews;


@property (strong, nonatomic) UIView *greyView;


-(void) setAveragesOne:(NSNumber *) one Two:(NSNumber *) two Three:(NSNumber *) three;
-(void) selectIndex:(NSInteger) index;


@end
