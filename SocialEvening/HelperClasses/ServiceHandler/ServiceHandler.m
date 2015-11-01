//
//  ServiceHandler.m
//  SocialEvening
//
//  Created by Naveen Shan on 31/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "ServiceHandler.h"

#import <AWSS3/AWSS3.h>
#import "AWSCloudLogic.h"
#import "AWSUserFileManager.h"
#import "AWSIdentityManager.h"

#import "AppConstants.h"
#import "NSString+DeviceAdditions.h"

@interface ServiceHandler ()

@end

@implementation ServiceHandler

+ (instancetype)sharedInstance {
    static ServiceHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

#pragma mark -

- (void)performLoginWithFacebook:(void (^)(id result, NSError *error))handler {
    [[AWSIdentityManager sharedInstance] loginWithSignInProvider:AWSSignInProviderTypeFacebook completionHandler:^(id result, NSError *error) {
//TODO - Modify the lamda faunction to chekc if user exists.
//Workaround for the above
        NSString *userId = [UserDefaultsWrapper savedMessageForKey:KAppUserId];
        if (userId.length == 0) {
            AWSIdentityManager *identityManager = [AWSIdentityManager sharedInstance];
            
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            if (identityManager.userName) {
                [parameters setValue:identityManager.userName forKey:@"fullName"];
                [parameters setValue:[NSString stringWithFormat:@"%@@facebook.com",identityManager.userName] forKey:@"emailId"];
                
                [parameters setValue:@1 forKey:@"loginType"];
                [self registerUser:parameters completion:handler];
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(result, error);
                });
            }
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(result, error);
            });
        }
    }];
}

- (void)handleLogout:(void (^)(id result, NSError *error))handler {
    if ([[AWSIdentityManager sharedInstance] isLoggedIn]) {
        [[AWSIdentityManager sharedInstance] logoutWithCompletionHandler:^(id result, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(result, error);
            });
        }];
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(nil, nil);
        });
    }
}

#pragma mark -

- (void)registerUser:(NSDictionary *)parameters completion:(void (^)(id result, NSError *error))handler {
//TODO optimize lamda function of register user.
// due to the impact of lamda function need to do the device handling logic in client.
    
    NSString *deviceConstant = [NSString getApplicationDeviceUUID];
    [self getDeviceDetails:deviceConstant completion:^(id result, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
        } else {
            if (result) {
                NSDictionary *deviceDetails = (NSDictionary *)result;
                [self registerUser:parameters devices:deviceDetails completion:handler];
            } else {
                [self registerDeviceWithCompletion:^(id result, NSError *error) {
                    if (error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            handler(nil, error);
                        });
                    } else {
//TODO modify lamda method to return device details.
// Workaround re-fetch data
                        [self getDeviceDetails:deviceConstant completion:^(id result, NSError *error) {
                            if (error) {
                                dispatch_async(dispatch_get_main_queue(), ^{
                                    handler(nil, error);
                                });
                            } else {
                                if (result) {
                                    NSDictionary *deviceDetails = (NSDictionary *)result;
                                    [self registerUser:parameters devices:deviceDetails completion:handler];
                                } else {
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        // handle custom error
                                        handler(nil, [NSError errorWithDomain:@"" code:500 userInfo:@{NSLocalizedDescriptionKey : @"Fail to find device details."}]);
                                    });
                                }
                            }
                        }];
                    }
                }];
            }
        }
    }];
}

- (void)registerUser:(NSDictionary *)userDetails devices:(NSDictionary *)deviceDetails completion:(void (^)(id, NSError *))handler {
    NSString *functionName = @"registerUser";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:userDetails];
    //Dynamo DB doesn't support auto increment. - Workaround here
    [parameters setValue:[NSString getUUID] forKey:@"userId"];
    [parameters setValue:@[deviceDetails[@"deviceConstant"]] forKey:@"devices"];
    
    [[AWSCloudLogic sharedInstance] invokeFunction:functionName withParameters:parameters
                               withCompletionBlock:^(id result, NSError *error) {
                                   if (result) {
                                       NSString *userId = parameters[@"userId"];
                                       [UserDefaultsWrapper saveMessage:userId key:KAppUserId];
                                   }
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       handler(result, error);
                                   });
                               }];
}

- (void)updateUser:(NSDictionary *)userDetails devices:(NSDictionary *)deviceDetails completion:(void (^)(id, NSError *))handler {
    NSString *functionName = @"updateUser";
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:userDetails];
//    [parameters setValue:@[deviceDetails[@"deviceConstant"]] forKey:@"devices"];
    
    [[AWSCloudLogic sharedInstance] invokeFunction:functionName withParameters:parameters
                               withCompletionBlock:^(id result, NSError *error) {
                                   
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       handler(result, error);
                                   });
                               }];
}

#pragma mark -

- (void)getDeviceDetails:(NSString *)deviceConstant completion:(void (^)(id result, NSError *error))handler {
    NSString *functionName = @"getDeviceDetails";
    NSDictionary *parameters = @{@"deviceConstant": deviceConstant};
    [[AWSCloudLogic sharedInstance] invokeFunction:functionName withParameters:parameters
                               withCompletionBlock:^(id result, NSError *error) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
// TODO - need to update device user id.
                                       handler (result, error);
                                   });
                               }];
}

- (void)registerDeviceWithCompletion:(void (^)(id result, NSError *error))handler {
    NSString *functionName = @"registerDevice";
    NSDictionary *parameters = @{@"deviceConstant": [NSString getApplicationDeviceUUID],
                                 @"deviceType": @"iOS",
                                 @"deviceUUID": @"NA",
                                 @"deviceModel": [NSString getDeviceType]};
    
    [[AWSCloudLogic sharedInstance] invokeFunction:functionName withParameters:parameters
                               withCompletionBlock:^(id result, NSError *error) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       handler(result, error);
                                   });
                               }];
}

#pragma mark -

- (void)imageForKey:(NSString *)key completion:(void (^)(UIImage *image))handler {
    [[AWSUserFileManager sharedManager] getContentWithKey:key completionHandler:^(AWSS3GetObjectOutput *result, NSError *error) {
        if (error) {
            NSLog(@"Image Download Error : %@",error);
        } else {
            //NSLog(@"Item : %@",result);
            NSData *imageData = result.body;
            UIImage *image = [UIImage imageWithData:imageData];
            if (handler) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    handler(image);
                });
            }
        }
    }];
}

- (void)uploadImage:(UIImage *)image key:(NSString *)key completion:(void (^)(NSError *error))handler {
    NSData *imageData = UIImagePNGRepresentation(image);
    AWSLocalContent *localContent = [[AWSUserFileManager sharedManager] localContentWithData:imageData key:key];
    [localContent uploadWithPinOnCompletion:NO progressBlock:^(AWSLocalContent *content, NSProgress *progress) {
        NSLog(@"Image upload progress : %@",progress.localizedDescription);
    } completionHandler:^(AWSLocalContent *content, NSError *error) {
        handler(error);
    }];
}

#pragma mark -

- (void)createTeam:(NSDictionary *)team image:(UIImage *)image completion:(void (^)(id result, NSError *error))handler {
    NSString *teamId = [NSString getUUID];
    [self uploadImage:image key:teamId completion:^(NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil, error);
            });
        } else {
            NSString *functionName = @"createTeam";
            NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
            [parameters addEntriesFromDictionary:team];
            //Dynamo DB doesn't support auto increment. - Workaround here
            [parameters setValue:teamId forKey:@"teamId"];
            [parameters setValue:teamId forKey:@"teamImageKey"];
            NSString *userId = [UserDefaultsWrapper savedMessageForKey:KAppUserId];
            if (userId.length > 0) {
                [parameters setValue:userId forKey:@"userId"];
//                [parameters setValue:@[userId] forKey:@"teamUserIds"];
            }
            
            [[AWSCloudLogic sharedInstance] invokeFunction:functionName withParameters:parameters
                                       withCompletionBlock:^(id result, NSError *error) {
//TODO update user table with team details.
                                           if (result) {
                                               NSString *teamId = parameters[@"teamId"];
                                               [UserDefaultsWrapper saveMessage:teamId key:KAppTeamId];
                                           }
                                           dispatch_async(dispatch_get_main_queue(), ^{
                                               handler(result, error);
                                           });
                                       }];
        }
    }];
}

- (void)getAllTeamsWithCompletion:(void (^)(id result, NSError *error))handler {
    NSString *functionName = @"getAllTeams";
    NSDictionary *parameters = @{};
    [[AWSCloudLogic sharedInstance] invokeFunction:functionName withParameters:parameters
                               withCompletionBlock:^(id result, NSError *error) {
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       handler (result, error);
                                   });
                               }];
}

@end
