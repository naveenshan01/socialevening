//
//  TeamListViewModel.m
//  SocialEvening
//
//  Created by Naveen Shan on 01/11/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "TeamListViewModel.h"

#import "AppConstants.h"

@implementation TeamListViewModel

- (void)loadTeamDetailsCompletion:(void (^)())handler {
    [[ServiceHandler sharedInstance] getAllTeamsWithCompletion:^(id result, NSError *error) {
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
            if ([result isKindOfClass:[NSDictionary class]]) {
                self.teams = (NSArray *)result[@"Items"];
            } else {
                [AlertView showAlert:@"Error" message:NSLocalizedString(@"Type mismatch in response, Please try again", nil)];
            }
        }
        if (handler) {
            handler();
        }
    }];
}

- (void)imageForTeam:(NSDictionary *)team completion:(void (^)(UIImage *image))handler {
    return [[ServiceHandler sharedInstance] imageForKey:team[@"teamImageKey"] completion:handler];
}

@end
