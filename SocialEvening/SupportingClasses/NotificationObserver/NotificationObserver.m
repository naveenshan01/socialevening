//
//  NotificationObserver.m
//  SocialEvening
//
//  Created by Naveen Shan on 29/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "NotificationObserver.h"

@interface NotificationObserver ()

@property (nonatomic, strong) NSString *notificationName;
@property (nonatomic, strong) id notificationObject;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, strong) NotificationObserverHandler handler;

@end

@implementation NotificationObserver

- (id)initWithNotificationNamed:(NSString *const)notificationName
                     fromObject:(const id)anObject
                          queue:(const dispatch_queue_t)aQueue
                       callback:(void (^)(NSNotification * const notification))handler  {
    self = [super init];
    
    if (self) {
        self.notificationName = [notificationName copy];
        self.notificationObject = anObject;
        self.queue = aQueue;
        self.handler = [handler copy];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationEvent:) name:notificationName object:anObject];
    }
    
    return self;
}

- (void)notificationEvent:(NSNotification *)aNotification {
    if (self.handler) {
        dispatch_async(self.queue, ^{
            self.handler(aNotification);
        });
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.notificationName object:self.notificationObject];
}

#pragma mark -

+ (void)postNotification:(NSString *)notificationName {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil];
}

#pragma mark -

+ (instancetype)observerForNotification:(NSString *)notificationName callback:(NotificationObserverHandler )handler {
    return [[self alloc] initWithNotificationNamed:notificationName fromObject:nil queue:dispatch_get_main_queue() callback:handler];
}

+ (instancetype)observerForNotification:(NSString *)notificationName object:(id)anObject callback:(NotificationObserverHandler )handler {
    return [[self alloc] initWithNotificationNamed:notificationName fromObject:anObject queue:dispatch_get_main_queue() callback:handler];
}


@end
