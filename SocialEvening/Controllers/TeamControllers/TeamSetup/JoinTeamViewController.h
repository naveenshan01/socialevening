//
//  JoinTeamViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "JoinTeamViewModel.h"
#import "JoinTeamInputModel.h"

@interface JoinTeamViewController : BaseViewController

@property (nonatomic, strong) JoinTeamViewModel *viewModel;

@property (nonatomic, strong) JoinTeamInputModel *inputModel;


@end
