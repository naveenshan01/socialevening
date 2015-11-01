//
//  SettingsViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "SettingsViewModel.h"
#import "SettingsInputModel.h"

@interface SettingsViewController : BaseViewController

@property (nonatomic, strong) SettingsViewModel *viewModel;

@property (nonatomic, strong) SettingsInputModel *inputModel;

@end
