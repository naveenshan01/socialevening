//
//  SignUpViewModel.h
//  SocialEvening
//
//  Created by Naveen Shan on 30/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SignUpViewModel : NSObject

@property (nonatomic, strong) NSString *fullName;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *confirmPassword;

- (BOOL)validateInputs;
- (void)registerUser;

@end
