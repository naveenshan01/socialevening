//
//  SignUpViewModel.m
//  SocialEvening
//
//  Created by Naveen Shan on 30/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "SignUpViewModel.h"

#import "AppConstants.h"

@implementation SignUpViewModel

- (BOOL)validateInputs {
    BOOL valid = YES;
    valid = valid && (self.fullName.length != 0);
    valid = valid && (self.email.length != 0);
    valid = valid && (self.password.length != 0);
    valid = valid && (self.confirmPassword.length != 0);
    valid = valid && ([self.password isEqualToString:self.confirmPassword]);
    
    return valid;
}

- (void)registerUser {
    if (![self validateInputs]) {
//TODO : Highlight the specific error fields
        [AlertView showAlert:NSLocalizedString(KAppName, nil) message:NSLocalizedString(@"Some required fields are missing", nil)];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@2 forKey:@"loginType"];
    [parameters setValue:self.fullName forKey:@"fullName"];
    [parameters setValue:self.email forKey:@"emailId"];
    [parameters setValue:self.password forKey:@"password"];
    
    [[ServiceHandler sharedInstance] registerUser:parameters completion:^(id result, NSError *error) {
        if (error) {
            // Test workaround need proper handling
//            if (error.code == 10) {
//                [AlertView showAlert:@"Error" message:@"Session Timeout" completionHandler:^(NSInteger buttonIndex, UIAlertController *alertController) {
//                    [UserDefaultsWrapper setUserLoginedStatus:NO];
//                    [NotificationObserver postNotification:KLoginNotification];
//                }];
//            } else {
//                [AlertView showError:error];
//            }
            
            NSString *message = [NSString stringWithFormat: @"Requires some more time to finish this tasks,\nWe required to implement a authentication with Mobile Hub IAM prior to any api call with Lambda, Otherwise it fails with authentication error.\n\nError form server : %@",error.localizedDescription];
            [AlertView showAlert:KAppName message:message];
        } else {
            [AlertView showAlert:KAppName message:NSLocalizedString(@"User Registerd Successfully", nil) completionHandler:^(NSInteger buttonIndex, UIAlertController *alertController) {
                [UserDefaultsWrapper setUserLoginedStatus:YES];
                [NotificationObserver postNotification:KLoginNotification];
            }];
        }
    }];
    
//    AWSCognito *syncClient = [AWSCognito defaultCognito];
//    
//    AWSCognitoDataset *socialEveUser = [syncClient openOrCreateDataset:@"SocialEveUser"];
//    [socialEveUser setString:self.fullName forKey:@"FullName"];
//    [socialEveUser setString:self.email forKey:@"Email"];
//    [socialEveUser setString:self.password forKey:@"Password"];
//    [[socialEveUser synchronize] continueWithBlock:^id(AWSTask *task) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            if (task.isCancelled) {
//                // Task cancelled.
//            } else if (task.error) {
//                [AlertView showError:task.error];
//            } else {
//                [AlertView showAlert:KAppName message:NSLocalizedString(@"User Registerd Successfully", nil) completionHandler:^(NSInteger buttonIndex, UIAlertController *alertController) {
//                    [UserDefaultsWrapper setUserLoginedStatus:YES];
//                    [NotificationObserver postNotification:KLoginNotification];
//                }];
//            }
//        });
//        return nil;
//    }];
}

@end
