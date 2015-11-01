//
//  SignUpViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "SignUpViewController.h"

#import "AppConstants.h"

@interface SignUpViewController ()

@property (nonatomic, assign) IBOutlet UITextField *emailField;
@property (nonatomic, assign) IBOutlet UITextField *fullNameField;
@property (nonatomic, assign) IBOutlet UITextField *passwordField;
@property (nonatomic, assign) IBOutlet UITextField *confirmPasswordField;

@end

@implementation SignUpViewController

- (void)initView {
    self.viewModel = [[SignUpViewModel alloc] init];
    self.inputModel = [[SignUpInputModel alloc] init];
}

#pragma mark - View Actions

- (IBAction)signUpButtonClicked:(id)sender {
    [self.view endEditing:YES];
    
    self.viewModel.email = self.emailField.text;
    self.viewModel.fullName = self.fullNameField.text;
    self.viewModel.password = self.passwordField.text;
    self.viewModel.confirmPassword = self.confirmPasswordField.text;
    
    [self.viewModel registerUser];
}

@end
