//
//  CreateTeamViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "CreateTeamViewModel.h"
#import "CreateTeamInputModel.h"

@interface CreateTeamViewController : BaseViewController

@property (nonatomic, strong) CreateTeamViewModel *viewModel;

@property (nonatomic, strong) CreateTeamInputModel *inputModel;

@end
