//
//  UserDefaultsWrapper.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsWrapper : NSObject

+ (BOOL)isUserLogined;
+ (void)setUserLoginedStatus:(BOOL)status;

+ (BOOL)isInTeam;
+ (void)setTeamStatus:(BOOL)status;

+ (id)savedMessageForKey:(NSString *)key;
+ (void)removeMessageForKey:(NSString *)key;
+ (void)saveMessage:(id)message key:(NSString *)key;

@end
