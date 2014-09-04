//
//  UIFont+fonts.h
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIFont (fonts)

+ (UIFont *)mainFontWithSize:(CGFloat) size;
+ (UIFont *)mainFontLightWithSize:(CGFloat) size;
+ (UIFont *)mainFontBoldWithSize:(CGFloat) size;

@end