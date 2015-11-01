//
//  NotificationObserver.h
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^NotificationObserverHandler)(NSNotification *notification);

@interface NotificationObserver : NSObject

+ (void)postNotification:(NSString *)notificationName;

+ (instancetype)observerForNotification:(NSString *)notificationName callback:(NotificationObserverHandler )handler;

+ (instancetype)observerForNotification:(NSString *)notificationName object:(id)anObject callback:(NotificationObserverHandler )handler;

@end
