//
//  AppDelegate.m
//  ZooApp
//
//  Created by Andrea Gerlach on 17.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <HockeySDK/HockeySDK.h>
#import "AppDelegate.h"
#import "AGFavManager.h"
#import "AGCoreDataHelper.h"
#import "AGJSONParser.h"

@interface AppDelegate (HockeySDK) //<BITHockeyManagerDelegate, BITUpdateManagerDelegate, BITCrashManagerDelegate>

@end

@implementation AppDelegate 

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    // HOCKEY
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"eb31056e81e2d9ab29f65c608df60689"
                                                           delegate:self];
    [[BITHockeyManager sharedHockeyManager] startManager];
    
    // UPDATE CORE DATA FROM JSON FILES
    [[AGJSONParser sharedInstance] updateCoreDataFromJSONFiles];

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
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor redColor]];

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - BITUpdateManagerDelegate
- (NSString *)customDeviceIdentifierForUpdateManager:(BITUpdateManager *)updateManager {
#ifndef CONFIGURATION_AppStore
    if ([[UIDevice currentDevice] respondsToSelector:@selector(uniqueIdentifier)])
        return [[UIDevice currentDevice] performSelector:@selector(uniqueIdentifier)];
#endif
    return nil;
}

- (BOOL) isFirstRun {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"isFirstRun"]) {
        return NO;
    }
    
    [defaults setObject:[NSDate date] forKey:@"isFirstRun"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return YES;
}
 

@end
