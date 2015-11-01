//
//  SettingsViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)initView {
    self.viewModel = [[SettingsViewModel alloc] init];
    self.inputModel = [[SettingsInputModel alloc] init];
}

#pragma mark - View Methods

- (NSString *)cellIdentifier:(NSIndexPath *)indexPath {
    NSString *identifier = @"Cell";
    switch (indexPath.row) {
        case 0:
            identifier = @"ProfileInfoCell";
            break;
        case 1:
            identifier = @"PushNotificatonCell";
            break;
        case 2:
            identifier = @"AboutUsCell";
            break;
        case 3:
            identifier = @"LogoutCell";
            break;
            
        default:
            break;
    }
    return identifier;
}

#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIdentifier:indexPath]];
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [self.viewModel performLogout];
    }
}

@end
