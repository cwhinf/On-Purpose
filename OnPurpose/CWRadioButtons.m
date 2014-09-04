//
//  CWRadioButtons.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "CWRadioButtons.h"

@interface CWRadioButtons ()

@property (strong, nonatomic) UIImage *unselectedButtonImage;
@property (strong, nonatomic) UIImage *selectedButtonImage;

@property (nonatomic) CGFloat borderThickness;

@property (strong, nonatomic) UIColor *innerColor;
@property (strong, nonatomic) UIColor *outerColor;

@property (strong, nonatomic) NSMutableArray *buttons;

@end


@implementation CWRadioButtons

- (id)init {

    if ([super init]) {
        self.buttons = [[NSMutableArray alloc] init];
        self.borderThickness = 20.0f;
        [self setColorsOuterColor:[UIColor blackColor] innerColor:[UIColor whiteColor]];
    }
    
    return self;
}

- (void) setButtonsFonts:(UIFont *)font {
    self.font = font;
    [self configureButtons];
}

- (void) setButtonsBorderThickness:(CGFloat)borderThickness {
    self.borderThickness = borderThickness;
    [self configureButtons];
}

- (void) setButtonsSelectedButton:(UIButton *)selectedButton {
    self.selectedButton = selectedButton;
    [self configureButtons];
}

- (void) addButton: (UIButton *)button {
    
    [self.buttons addObject:button];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self configureButtons];
}


- (void) setColorsOuterColor:(UIColor *) outerColor innerColor:(UIColor *) innerColor {
    
    self.outerColor = outerColor;
    self.innerColor = innerColor;
    
    CGPoint center = CGPointMake(80.0f, 80.0f);
    CGRect frame = CGRectMake(0.0f, 0.0f, 160.0f, 160.0f);
    
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0f);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    
    //stroke outer circle
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), frame.size.width);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.outerColor.CGColor);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.selectedButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //stroke inner circle
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), frame.size.width - self.borderThickness);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.innerColor.CGColor);
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), center.x, center.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.unselectedButtonImage = UIGraphicsGetImageFromCurrentImageContext();
    
    [self configureButtons];
    
}

- (void) configureButtons {
    
    if (self.buttons) {
        for (UIButton *button in self.buttons) {
            
            [button.titleLabel setFont:self.font];
            
            if ([self.selectedButton isEqual:button]) {
                [button setBackgroundImage:self.selectedButtonImage forState:UIControlStateNormal];
                [button setTitleColor:self.innerColor forState:UIControlStateNormal];
            }
            else {
                [button setBackgroundImage:self.unselectedButtonImage forState:UIControlStateNormal];
                [button setTitleColor:self.outerColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void) buttonPressed: (UIButton *)sender {
    
    self.selectedButton = sender;
    [self configureButtons];
    if ([self.delegate respondsToSelector:@selector(buttonSelected:)]) {
        [self.delegate buttonSelected:sender];
    }
    
    
}










@end
