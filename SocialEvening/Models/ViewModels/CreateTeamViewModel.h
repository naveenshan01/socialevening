//
//  CreateTeamViewModel.h
//  SocialEvening
//
//  Created by Naveen Shan on 31/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class CLLocation;

@interface CreateTeamViewModel : NSObject

@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *teamPlaceMark;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (nonatomic, strong) UIImage *teamImage;

- (void)fetchUserLocation;

- (void)createTeam;

@end
