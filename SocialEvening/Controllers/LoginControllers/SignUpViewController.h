//
//  SignUpViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "SignUpViewModel.h"
#import "SignUpInputModel.h"

@interface SignUpViewController : BaseViewController

@property (nonatomic, strong) SignUpViewModel *viewModel;

@property (nonatomic, strong) SignUpInputModel *inputModel;

@end
