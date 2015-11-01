//
//  AlertView.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "AlertView.h"

@implementation AlertView

+ (UIViewController *)presentationContorller    {
    UIViewController *presentationContorller = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if (![presentationContorller isMemberOfClass:[UIViewController class]]) {
        if ([presentationContorller isKindOfClass:[UITabBarController class]]) {
            presentationContorller = ((UITabBarController *)presentationContorller).selectedViewController;
        } else if ([presentationContorller isKindOfClass:[UINavigationController class]]) {
            presentationContorller = ((UINavigationController *)presentationContorller).topViewController;
        }
        else {
            presentationContorller = presentationContorller.presentedViewController;
        }
    }
    
    return presentationContorller;
}

#pragma mark -

+ (void)showAlert:(NSString *)alertMessage  {
    [[self class] showAlert:@"" message:alertMessage completionHandler:nil];
}

+ (void)showError:(NSError *)error  {
    [[self class] showAlert:NSLocalizedString(@"Error",nil) message:error.localizedDescription completionHandler:nil];
}

+ (void)showAlert:(NSString *)alertTitle message:(NSString *)alertMessage {
    [[self class] showAlert:alertTitle message:alertMessage completionHandler:nil];
}

+ (void)showAlert:(NSString *)alertTitle message:(NSString *)alertMessage completionHandler:(AlertCompletionHandler)handler {
    [[self class] showAlert:alertTitle message:alertMessage okButtonTitle:NSLocalizedString(@"OK",nil) cancelButtonTitle:nil completionHandler:handler];
}

+ (void)showAlert:(NSString *)alertTitle message:(NSString *)alertMessage okButtonTitle:(NSString *)okButtontitle cancelButtonTitle:(NSString *)cancelButtontitle completionHandler:(AlertCompletionHandler)handler     {
    @try {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertMessage preferredStyle:UIAlertControllerStyleAlert];

        if (okButtontitle && cancelButtontitle) {
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:okButtontitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (handler) {
                    handler(0,alertController);
                }
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:okButtontitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (handler) {
                    handler(1,alertController);
                }
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:okButton];
            [alertController addAction:cancelButton];
        } else if (okButtontitle) {
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:okButtontitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (handler) {
                    handler(0,alertController);
                }
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:okButton];
        } else if (cancelButtontitle) {
            UIAlertAction *cancelButton = [UIAlertAction actionWithTitle:okButtontitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                if (handler) {
                    handler(0,alertController);
                }
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:cancelButton];
        } else {
            okButtontitle = NSLocalizedString(@"Ok", nil);
            UIAlertAction *okButton = [UIAlertAction actionWithTitle:okButtontitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [alertController dismissViewControllerAnimated:YES completion:nil];
            }];
            [alertController addAction:okButton];
        }
        
        [[[self class] presentationContorller] presentViewController:alertController animated:YES completion:nil];
    }
    @catch (NSException *e) {
        
    }
    @finally {
        
    }
}

@end
