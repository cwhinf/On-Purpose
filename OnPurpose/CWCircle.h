//
//  CWCircle.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CWCircle : UIView {
    UIColor *arrowCr;
    UIColor *strokeCr;
    BOOL arrow;
}

@property (strong, nonatomic) UIColor *circleColor;
@property (nonatomic) float borderThickness;

- (id)initWithFrame:(CGRect)theFrame arrowColor:(UIColor *)arrowColor strokeColor:(UIColor *)strokeColor isUpArrow:(BOOL)arrowType ;
- (id)initWithFrame:(CGRect)theFrame CircleColor:(UIColor *)circleColor;


@end
