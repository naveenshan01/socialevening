//
//  TeamListViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "TeamListViewController.h"

#import "TeamListViewCell.h"
#import "TeamChallengeViewController.h"

@interface TeamListViewController ()

@property (nonatomic, assign) IBOutlet UICollectionView *collectionView;

@end

@implementation TeamListViewController

- (void)initView {
    self.viewModel = [[TeamListViewModel alloc] init];
    self.inputModel = [[TeamListInputModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.viewModel loadTeamDetailsCompletion:^{
        [self.collectionView reloadData];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showTeamDetail"]) {
        TeamChallengeViewController *destinationController = segue.destinationViewController;
        destinationController.inputModel.team = ((TeamListViewCell *) sender).team;
    }
}

#pragma mark - UICollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewModel.teams.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 200;
    return CGSizeMake(collectionView.frame.size.width - 30.0f, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeamListViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamListCell" forIndexPath:indexPath];
    
//TODO Create model class for response objects.
    NSDictionary *team = self.viewModel.teams[indexPath.item];
    cell.team = team;
    cell.titleLabel.text = team[@"teamName"];
    [self.viewModel imageForTeam:team completion:^(UIImage *image) {
        [cell setImage:image];
    }];
    
    return cell;
}

@end
