//
//  LoginHomeViewModel.m
//  SocialEvening
//
//  Created by Naveen Shan on 30/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "LoginHomeViewModel.h"

#import "AppConstants.h"

@implementation LoginHomeViewModel

- (void)performFacebookLogin {
    [[ServiceHandler sharedInstance] performLoginWithFacebook:^(id result, NSError *error) {
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
            [UserDefaultsWrapper setUserLoginedStatus:YES];
            [NotificationObserver postNotification:KLoginNotification];
        }
    }];
}

@end
