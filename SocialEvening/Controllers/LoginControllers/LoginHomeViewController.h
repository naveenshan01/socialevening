//
//  LoginHomeViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "LoginHomeViewModel.h"
#import "LoginHomeInputModel.h"

@interface LoginHomeViewController : BaseViewController

@property (nonatomic, strong) LoginHomeViewModel *viewModel;

@property (nonatomic, strong) LoginHomeInputModel *inputModel;

@end
