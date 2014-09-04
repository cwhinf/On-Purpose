//
//  VRGViewController.h
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRGCalendarView.h"

@protocol CalendarViewControllerDelegate <NSObject>

- (void)calendarDidPickDate:(NSDate *) date;

@end

@interface CalendarViewController : UIViewController <VRGCalendarViewDelegate>

@property (strong, nonatomic) id<CalendarViewControllerDelegate> delegate;

@property (strong, nonatomic) UIColor *graphColor;
@property (strong, nonatomic) NSDate *currentDate;

- (IBAction)backPressed:(id)sender;

@end
