//
//  TeamListViewController.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "BaseViewController.h"

#import "TeamListViewModel.h"
#import "TeamListInputModel.h"

@interface TeamListViewController : BaseViewController

@property (nonatomic, strong) TeamListViewModel *viewModel;

@property (nonatomic, strong) TeamListInputModel *inputModel;

@end
