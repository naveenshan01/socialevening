//
//  NSString+DeviceAdditions.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (DeviceAdditions)

// To get a Universal Unique Identifier.
+ (NSString *)getUUID;

// To get Universal Unique Identifier for this device specifically for this app use.
+ (NSString *)getApplicationDeviceUUID;

+ (NSString *)getApplicationCurrentVersion;
+ (NSString *)getDeviceType;

@end
