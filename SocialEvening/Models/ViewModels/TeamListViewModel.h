//
//  TeamListViewModel.h
//  SocialEvening
//
//  Created by Naveen Shan on 01/11/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TeamListViewModel : NSObject

@property (nonatomic, strong) NSArray *teams;

- (void)loadTeamDetailsCompletion:(void (^)())handler;

- (void)imageForTeam:(NSDictionary *)team completion:(void (^)(UIImage *image))handler;

@end
