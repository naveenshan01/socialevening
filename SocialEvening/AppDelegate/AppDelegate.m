//
//  AppDelegate.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "AppDelegate.h"

#import "AppConstants.h"
#import "AWSMobileClient.h"

@interface AppDelegate ()

@property (nonatomic, strong) NotificationObserver *loginObserver;
@property (nonatomic, strong) NotificationObserver *joinTeamObserver;

@end

@implementation AppDelegate

#pragma mark - App Initialization

- (void)initApplication {
    [self customizeAppearance];
    
    [self setRootViewController];
    [self observeUserStatusChange];
}

- (void)customizeAppearance {
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

- (void)setRootViewController {
    if (![UserDefaultsWrapper isUserLogined]) {
        // show login scenes
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:KLoginScene bundle:[NSBundle mainBundle]];
        UIViewController *initialViewController = [storyboard instantiateInitialViewController];
        
        self.window.rootViewController = initialViewController;
        
        return;
    }
    if (![UserDefaultsWrapper isInTeam]) {
        // show join team scenes
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:KTeamSetupScene bundle:[NSBundle mainBundle]];
        UIViewController *initialViewController = [storyboard instantiateInitialViewController];
        
        self.window.rootViewController = initialViewController;
        return;
    }
    
    // show socialing scenes
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:KMainTabScene bundle:[NSBundle mainBundle]];
    UIViewController *initialViewController = [storyboard instantiateInitialViewController];
    
    self.window.rootViewController = initialViewController;
}

- (void)observeUserStatusChange {
    self.loginObserver = [NotificationObserver observerForNotification:KLoginNotification callback:^(NSNotification *notification) {
        [self setRootViewController];
    }];
    
    self.joinTeamObserver = [NotificationObserver observerForNotification:KJoinTeamNotification callback:^(NSNotification *notification) {
        [self setRootViewController];
    }];
}

#pragma mark - UIApplication Delegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self initApplication];
    [self.window makeKeyAndVisible];
    return [[AWSMobileClient sharedInstance] didFinishLaunching:application withOptions:launchOptions];
}

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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
//    [[AWSMobileClient sharedInstance] applicationDidBecomeActive:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation {
    return [[AWSMobileClient sharedInstance] withApplication:application withURL:url withSourceApplication:sourceApplication withAnnotation:annotation];
}

// For iOS9.0 and above
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
//    return [[AWSMobileClient sharedInstance] withApplication:app withURL:url withSourceApplication:nil withAnnotation:nil];
//}

@end
