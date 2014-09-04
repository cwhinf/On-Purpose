//
//  CWCircle.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 9/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "CWCircle.h"

@implementation CWCircle

- (id)initWithFrame:(CGRect)theFrame arrowColor:(UIColor *)arrowColor strokeColor:(UIColor *)strokeColor isUpArrow:(BOOL)arrowType ;
{
    self = [super initWithFrame:theFrame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        arrowCr =arrowColor;
        strokeCr = strokeColor;
        arrow = arrowType;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)theFrame CircleColor:(UIColor *)circleColor {
    self = [super initWithFrame:theFrame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.circleColor = circleColor;
        self.borderThickness = 5.0f;
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    
    CGPoint center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    
    // Get the current graphics context
    // (ie. where the drawing should appear)
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context, kCGLineCapRound);
    
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddLineToPoint(context, center.x, center.y);
    
    //stroke outer circle
    CGContextSetLineWidth(context, self.frame.size.height);
    CGContextSetStrokeColorWithColor(context, self.circleColor.CGColor);
    CGContextStrokePath(context);
    
    //stroke inner circle
    CGContextSetLineWidth(context, self.frame.size.height - self.borderThickness);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddLineToPoint(context, center.x, center.y);
    CGContextSetBlendMode(context,kCGBlendModeDestinationOut);
    CGContextStrokePath(context);

    /*
    if (arrow) {
        
        // Starting Point
        CGContextMoveToPoint(context, rect.size.width/2,0);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height);
        CGContextAddLineToPoint(context, 0, rect.size.height);
        // Close the path
        
    }
    else
    {
        // Starting Point
        CGContextMoveToPoint(context, 0,0);
        CGContextAddLineToPoint(context, rect.size.width, 0);
        CGContextAddLineToPoint(context, rect.size.width/2, rect.size.height);
        // Close the path
        
    }
    // Closing the path will extending a line from
    CGContextClosePath(context);
    // Set line width
    CGContextSetLineWidth(context, 2.0);
    // Set colour using RGB intensity values
    CGContextSetFillColorWithColor(context, arrowCr.CGColor);
    CGContextSetStrokeColorWithColor(context, strokeCr.CGColor);
    //Draw on the screen
    CGContextDrawPath(context, kCGPathFillStroke);
     */
}


@end
