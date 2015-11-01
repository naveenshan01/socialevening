//
//  JoinTeamViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "JoinTeamViewController.h"

@interface JoinTeamViewController ()

@end

@implementation JoinTeamViewController

- (void)initView {
    self.viewModel = [[JoinTeamViewModel alloc] init];
    self.inputModel = [[JoinTeamInputModel alloc] init];
}

#pragma mark - View Methods

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [UITableViewCell new];
}


@end
