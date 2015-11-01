//
//  AWSCloudLogic.m
//
//
// Copyright 2015 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//

#import <Foundation/Foundation.h>
#import "AWSCloudLogic.h"
#import <AWSLambda/AWSLambda.h>
#import "AWSTask+CheckExceptions.h"

@interface AWSCloudLogic ()

@property AWSLambdaInvoker *invoker;

@end

@implementation AWSCloudLogic

+ (instancetype)sharedInstance {
    static AWSCloudLogic* client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[self alloc] init];
    });
    
    return client;
}

- (instancetype)init {
    if (self = [super init]) {
        _invoker = [AWSLambdaInvoker defaultLambdaInvoker];
    }
    return self;
}

- (void)invokeFunction:(NSString *)name withParameters:(NSDictionary *)parameters
  withCompletionBlock:(void (^)(NSDictionary *result, NSError *error))completionBlock {
    AWSLogDebug(@"invokeFunction: Function Name: %@", name);
    [[_invoker invokeFunction:name JSONObject:parameters] continueWithBlock:^id(AWSTask *task) {
        if (task.error) {
            AWSLogError(@"invokeFunction: Error: %@", [task.error localizedDescription]);
        }
        
        if (task.exception) {
            AWSLogError(@"invokeFunction: Exception: %@", task.exception.reason);
            @throw task.exception;
        }

        completionBlock(task.result, task.error);
        return nil;
    }];
}

@end
