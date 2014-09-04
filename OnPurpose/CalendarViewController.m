//
//  VRGViewController.m
//  Vurig Calendar
//
//  Created by in 't Veen Tjeerd on 5/29/12.
//  Copyright (c) 2012 Vurig. All rights reserved.
//

#import "CalendarViewController.h"
#import "NSDate+convenience.h"
#import "UIColor+colors.h"

@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    if (self.graphColor) {
        calendar.mainColor = self.graphColor;
    }
    else {
        calendar.mainColor = [UIColor OPAquaColor];
    }
    if (self.currentDate) {
        [calendar setSelectedDate:self.currentDate];
    }
    else {
        [calendar setSelectedDate:[NSDate date]];
    }
    CGRect frame = CGRectMake(0.0f, 64.0f, calendar.frame.size.width, calendar.frame.size.height);
    calendar.frame = frame;
    calendar.delegate=self;
    [self.view addSubview:calendar];
    
    
    
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    /*
    if (month==[[NSDate date] month]) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
     */
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    
    NSLog(@"Selected date = %@",date);
    [self.delegate calendarDidPickDate:date];
    double delayInSeconds = 0.2f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //code to be executed on the main queue after delay
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


@end











