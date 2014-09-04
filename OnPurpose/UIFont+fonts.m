//
//  UIFont+fonts.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/3/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "UIFont+fonts.h"

@implementation UIFont (fonts)

+ (UIFont *)mainFontWithSize:(CGFloat) size {
    return [UIFont fontWithName:@"OpenSans" size:size];
}

+ (UIFont *)mainFontLightWithSize:(CGFloat) size {
    return [UIFont fontWithName:@"OpenSans-Light" size:size];
}

+ (UIFont *)mainFontBoldWithSize:(CGFloat) size {
    return [UIFont fontWithName:@"OpenSans-Bold" size:size];
}


@end

