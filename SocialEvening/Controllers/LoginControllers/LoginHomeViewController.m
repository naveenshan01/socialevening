//
//  LoginHomeViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "LoginHomeViewController.h"

@interface LoginHomeViewController ()

@end

@implementation LoginHomeViewController

- (void)initView {
    self.viewModel = [[LoginHomeViewModel alloc] init];
    self.inputModel = [[LoginHomeInputModel alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:YES];
}

#pragma mark - View Methods 

- (void)hideNavigationBar:(BOOL)hide {
    self.navigationController.navigationBarHidden = hide;
}

#pragma mark - View Actions

- (IBAction)facebookSignInClicked:(id)sender {
    [self.viewModel performFacebookLogin];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    [self hideNavigationBar:NO];
}

@end
