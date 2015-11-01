//
//  UserDefaultsWrapper.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "UserDefaultsWrapper.h"

@implementation UserDefaultsWrapper

+ (BOOL)isUserLogined {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserLogined"] boolValue];
}

+ (void)setUserLoginedStatus:(BOOL)status {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:status] forKey:@"UserLogined"];
    [defaults synchronize];
}

#pragma mark -

+ (BOOL)isInTeam {
    return [[[NSUserDefaults standardUserDefaults] objectForKey:@"UserJoinedTeam"] boolValue];
}

+ (void)setTeamStatus:(BOOL)status {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:status] forKey:@"UserJoinedTeam"];
    [defaults synchronize];
}

#pragma mark -

+ (void)saveMessage:(id)message key:(NSString *)key {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:message forKey:key];
    [defaults synchronize];
}

+ (id)savedMessageForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (void)removeMessageForKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

@end
