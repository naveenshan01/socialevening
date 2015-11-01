//
//  TeamChallengeViewModel.m
//  SocialEvening
//
//  Created by Naveen Shan on 01/11/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "TeamChallengeViewModel.h"

#import "AppConstants.h"

@implementation TeamChallengeViewModel

- (void)imageForTeam:(NSDictionary *)team completion:(void (^)(UIImage *image))handler {
    return [[ServiceHandler sharedInstance] imageForKey:team[@"teamImageKey"] completion:handler];
}

@end
