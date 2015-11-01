//
//  NSString+DeviceAdditions.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "NSString+DeviceAdditions.h"

#import <UIKit/UIKit.h>

@implementation NSString (DeviceAdditions)

#pragma mark - UUID

+ (NSString *)getUUID {
    CFUUIDRef UUIDObj = CFUUIDCreate(nil);
    NSString *UUIDString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, UUIDObj);
    CFRelease(UUIDObj);
    
    return UUIDString;
}

+ (NSString *)getApplicationDeviceUUID {
    if ([self savedUUID]) {
        return [self savedUUID];
    }
    NSString *UUIDString = [self getUUID];
    [self saveUUID:UUIDString];
    
    return UUIDString;
}

+ (NSString *)savedUUID {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"ApplicationDeviceUUID"];
}

+ (void)saveUUID:(NSString *)UUIDString {
    if (! UUIDString) {
        return;
    }
    [[NSUserDefaults standardUserDefaults] setObject:UUIDString forKey:@"ApplicationDeviceUUID"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getApplicationCurrentVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];;
}

+ (NSString *)getDeviceType {
    return [UIDevice currentDevice].model;
}


@end
