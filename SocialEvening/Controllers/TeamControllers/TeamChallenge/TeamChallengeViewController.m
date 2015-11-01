//
//  TeamChallengeViewController.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "TeamChallengeViewController.h"

@interface TeamChallengeViewController ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation TeamChallengeViewController

- (void)initView {
    self.viewModel = [[TeamChallengeViewModel alloc] init];
    self.inputModel = [[TeamChallengeInputModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)loadData {
    self.title = self.inputModel.team[@"teamName"];
    self.titleLabel.text = self.inputModel.team[@"teamName"];
    [self.viewModel imageForTeam:self.inputModel.team completion:^(UIImage *image) {
        self.imageView.image = image;
        [self.activityIndicator stopAnimating];
    }];
}

#pragma mark - UICollectionView Datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 175;
    return CGSizeMake(collectionView.frame.size.width, height);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TeamChallengeCell" forIndexPath:indexPath];
    
    return cell;
}

@end
