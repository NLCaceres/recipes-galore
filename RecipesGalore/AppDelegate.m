//
//  AppDelegate.m
//  RecipesGalore
//
//  Created by Lionel Caceres on 12/10/15.
//  Copyright (c) 2015 Nicholas Caceres. All rights reserved.
//

#import "AppDelegate.h"

//#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


// MARK: Relevant to Google SignIn
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // ClientID should be included in a singleton that handles user config (UserDefault's NOT a good idea)
    // GIDSignIn.sharedInstance.clientID = @"232628018883-27hcdprf6mgtp9vlepfeg418va5qbv09.apps.googleusercontent.com";
    
    [GIDSignIn.sharedInstance restorePreviousSignInWithCallback:^(GIDGoogleUser * _Nullable user,
                                                                  NSError * _Nullable error) {
        if (error) {
            // Show a signed-out state
        }
        else {
            // Show Signed in state
        }
    }];
    
    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    tabBarController.selectedIndex = 1;
    
    return YES;
}

- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<NSString *, id> *)options {
    BOOL handled;

    handled = [GIDSignIn.sharedInstance handleURL:url];
    if (handled) {
        return YES;
    }

    // Handle other custom URL types.

    // If not handled by this app, return NO.
    return NO;
}

// Sign in and Sign out protocol methods included from original delegate. Can reuse in above callback
- (void)signIn:(GIDSignIn *)signIn didSignInForUser:(GIDGoogleUser *)user withError:(NSError *)error {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    // Perform any operations on signed in user here.
    NSString *userId = user.userID;                  // For client-side use only!
    [defaults setValue:userId forKey:@"UserID"];
    NSString *idToken = user.authentication.idToken; // Safe to send to the server
    NSString *fullName = user.profile.name;
    [defaults setValue:fullName forKey:@"UserFullName"];
    NSString *givenName = user.profile.givenName;
    NSString *familyName = user.profile.familyName;
    NSString *email = user.profile.email;
    [defaults setValue:email forKey:@"UserEmail"];
    
    [defaults synchronize]; // Forces it to save (not entirely necessary but guarantees it)
    
    UITabBarController *mainTabBarController = (UITabBarController *) self.window.rootViewController;
    [mainTabBarController dismissViewControllerAnimated:YES completion:nil];
    [mainTabBarController.tabBar setHidden:NO];
    
    // Handle all other sign in related tasks here
}
- (void)signIn:(GIDSignIn *)signIn
    didDisconnectWithUser:(GIDGoogleUser *)user
     withError:(NSError *)error {
    // Perform any operations when the user disconnects from app here.
}

@end
