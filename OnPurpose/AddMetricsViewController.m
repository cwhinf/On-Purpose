//
//  AddMetricsViewController.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import "AddMetricsViewController.h"

#import "Constants.h"

@interface AddMetricsViewController ()

@property (strong, nonatomic) PFLogInViewController *parseLogInViewController;


@property (strong, nonatomic) IBOutlet UISegmentedControl *sleepSelector;
@property (strong, nonatomic) IBOutlet UISegmentedControl *presenceSelector;
@property (strong, nonatomic) IBOutlet UISegmentedControl *activitySelector;
@property (strong, nonatomic) IBOutlet UISegmentedControl *creativitySelector;
@property (strong, nonatomic) IBOutlet UISegmentedControl *eatingSelector;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;



- (IBAction)addPressed:(id)sender;

- (IBAction)logOutPressed:(id)sender;

- (IBAction)backPressed:(id)sender;



@end

@implementation AddMetricsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self checkForUser];
}

- (bool) checkForUser {
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        self.parseLogInViewController = [[PFLogInViewController alloc] init];
        self.parseLogInViewController.delegate = self;
        self.parseLogInViewController.fields = PFLogInFieldsUsernameAndPassword | PFLogInFieldsLogInButton | PFLogInFieldsSignUpButton;
        
        PFSignUpViewController *parseSignUpViewController = [[PFSignUpViewController alloc] init];
        parseSignUpViewController.delegate = self;
        parseSignUpViewController.fields = PFSignUpFieldsUsernameAndPassword| PFSignUpFieldsDismissButton | PFSignUpFieldsSignUpButton;
        self.parseLogInViewController.signUpController = parseSignUpViewController;
        
        
        // Present the log in view controller
        [self presentViewController:self.parseLogInViewController animated:YES completion:NULL];
        
        return FALSE;
    }
    else {
        return TRUE;
    }
}

- (void) logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [self.parseLogInViewController dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addPressed:(id)sender {
    
    PFObject *metrics = [PFObject objectWithClassName:metricsClassKey];
    
    [metrics setObject:[PFUser currentUser] forKey:metricsUserKey];
    [metrics setObject:[NSNumber numberWithInteger:self.sleepSelector.selectedSegmentIndex + 1] forKey:metricsSleepKey];
    [metrics setObject:[NSNumber numberWithInteger:self.presenceSelector.selectedSegmentIndex + 1] forKey:metricsPresenceKey];
    [metrics setObject:[NSNumber numberWithInteger:self.activitySelector.selectedSegmentIndex + 1] forKey:metricsActivityKey];
    [metrics setObject:[NSNumber numberWithInteger:self.creativitySelector.selectedSegmentIndex + 1] forKey:metricsCreativityKey];
    [metrics setObject:[NSNumber numberWithInteger:self.eatingSelector.selectedSegmentIndex + 1] forKey:metricsEatingKey];
    
    [metrics setObject:[self.datePicker date] forKey:metricsDayKey];
    
    
    [metrics saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Metrics Saved"
                                                            message:@"Metrics have been saved"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)logOutPressed:(id)sender {
    [PFUser logOut];
    [self checkForUser];
    
}


- (IBAction)backPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end










