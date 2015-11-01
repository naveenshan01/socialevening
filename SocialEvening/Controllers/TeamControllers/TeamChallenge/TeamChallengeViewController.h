//
//  TeamChallengeViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "TeamChallengeViewModel.h"
#import "TeamChallengeInputModel.h"

@interface TeamChallengeViewController : BaseViewController

@property (nonatomic, strong) TeamChallengeViewModel *viewModel;

@property (nonatomic, strong) TeamChallengeInputModel *inputModel;

@end
