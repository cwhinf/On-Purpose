//
//  CWRadioButtons.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/24/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CWRadioButtonsDelegate <NSObject>

@optional
- (void) buttonSelected:(UIButton *)button;

@end


@interface CWRadioButtons : NSObject

@property (strong, nonatomic) id <CWRadioButtonsDelegate> delegate;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIButton *selectedButton;

- (void) setButtonsFonts:(UIFont *)font;
- (void) setButtonsBorderThickness:(CGFloat)borderThickness;
- (void) setButtonsSelectedButton:(UIButton *)selectedButton;


- (void) addButton: (UIButton *)button;


- (void) setColorsOuterColor:(UIColor *) outerColor innerColor:(UIColor *) innerColor;


@end
