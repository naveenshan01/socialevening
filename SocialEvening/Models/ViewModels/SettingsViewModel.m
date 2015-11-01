//
//  SettingsViewModel.m
//  SocialEvening
//
//  Created by Naveen Shan on 01/11/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "SettingsViewModel.h"

#import "AppConstants.h"

@implementation SettingsViewModel

- (void)performLogout {
    [[ServiceHandler sharedInstance] handleLogout:^(id result, NSError *error) {
        if (error) {
            // Test workaround need proper handling
            if (error.code == 10) {
                [AlertView showAlert:@"Error" message:@"Session Timeout" completionHandler:^(NSInteger buttonIndex, UIAlertController *alertController) {
                    [UserDefaultsWrapper setUserLoginedStatus:NO];
                    [NotificationObserver postNotification:KLoginNotification];
                }];
            } else {
                [AlertView showError:error];
            }
        } else {
            [UserDefaultsWrapper setUserLoginedStatus:NO];
            [NotificationObserver postNotification:KLoginNotification];
        }
    }];
}

@end
