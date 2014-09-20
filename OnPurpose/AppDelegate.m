//
//  AppDelegate.m
//  OnPurpose
//
//  Created by Chris Whinfrey on 8/2/14.
//  Copyright (c) 2014 Dungbeetle. All rights reserved.
//

#import <Parse/Parse.h>

#import "AppDelegate.h"
#import "MainTabBarController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"RVyFn0t703dpFLBXBIT6TeSPNDY9nylxSd18AseW" clientKey:@"Z4ydB4Xlxd7co4y5en8ieK2XmR5Lg7pE0Iv9lExu"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    self.mainTabBarController = [storyboard instantiateViewControllerWithIdentifier:@"mainTabBarController"];
        
    //self.paperFoldNavController = [[PaperFoldNavigationController alloc] initWithRootViewController:mainTabBarController];
    
    //mainTabBarController.paperFoldNavController = self.paperFoldNavController;
    
    //self.menuViewController = [storyboard instantiateViewControllerWithIdentifier:@"menuViewController"];
    //self.menuViewController.paperFoldNavController = self.paperFoldNavController;
    
    //[self.paperFoldNavController setLeftViewController:self.menuViewController width:180.0f];
    
    self.window.rootViewController = self.mainTabBarController;//self.paperFoldNavController;
    
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
