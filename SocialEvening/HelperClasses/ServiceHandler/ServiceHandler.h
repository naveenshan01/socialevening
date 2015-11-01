//
//  ServiceHandler.h
//  SocialEvening
//
//  Created by Naveen Shan on 31/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface ServiceHandler : NSObject

+ (instancetype)sharedInstance;

- (void)performLoginWithFacebook:(void (^)(id result, NSError *error))handler;

- (void)handleLogout:(void (^)(id result, NSError *error))handler;

- (void)registerUser:(NSDictionary *)parameters completion:(void (^)(id result, NSError *error))hander;

- (void)getDeviceDetails:(NSString *)deviceConstant completion:(void (^)(id result, NSError *error))handler;

- (void)createTeam:(NSDictionary *)team image:(UIImage *)image completion:(void (^)(id result, NSError *error))handler;

- (void)getAllTeamsWithCompletion:(void (^)(id result, NSError *error))handler;

- (void)imageForKey:(NSString *)key completion:(void (^)(UIImage *image))handler;

@end
