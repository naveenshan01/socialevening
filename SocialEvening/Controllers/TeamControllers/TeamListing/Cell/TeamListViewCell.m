//
//  TeamListViewCell.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "TeamListViewCell.h"

@implementation TeamListViewCell

- (void)setImage:(UIImage *)image {
    self.imageView.image = image;
    [self.activityIndicator stopAnimating];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.text = nil;
    self.imageView.image = nil;
    [self.activityIndicator startAnimating];
}

@end
