//
//  SignInViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "SignInViewModel.h"
#import "SignInInputModel.h"

@interface SignInViewController : BaseViewController

@property (nonatomic, strong) SignInViewModel *viewModel;

@property (nonatomic, strong) SignInInputModel *inputModel;

@end
