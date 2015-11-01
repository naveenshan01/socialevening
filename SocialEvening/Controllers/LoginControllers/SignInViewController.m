//
//  SignInViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "SignInViewController.h"

#import "AppConstants.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)initView {
    self.viewModel = [[SignInViewModel alloc] init];
    self.inputModel = [[SignInInputModel alloc] init];
}

#pragma mark - View Actions

- (IBAction)signInButtonClicked:(id)sender {
    [self.view endEditing:YES];
    
    [AlertView showAlert:KAppName message:@"Not Implemented - Need to write proper Lambda function for this"];
}

@end
