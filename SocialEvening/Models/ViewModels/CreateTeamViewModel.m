//
//  CreateTeamViewModel.m
//  SocialEvening
//
//  Created by Naveen Shan on 31/10/15.
//  Copyright © 2015 American Ventures LLC. All rights reserved.
//

#import "CreateTeamViewModel.h"

#import "AppConstants.h"
#import <CoreLocation/CoreLocation.h>

@interface CreateTeamViewModel () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLGeocoder *geocoder;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation CreateTeamViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        self.geocoder = [[CLGeocoder alloc] init];
    }
    return self;
}

#pragma mark -

- (void)fetchUserLocation {
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined ||
        authorizationStatus == kCLAuthorizationStatusDenied) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}

- (void)findPlaceForLocation {
    [self.geocoder reverseGeocodeLocation:self.currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error == nil && [placemarks count] > 0) {
            CLPlacemark *placemark = [placemarks lastObject];
            self.teamPlaceMark = [NSString stringWithFormat:@"%@ %@ %@",placemark.locality,placemark.administrativeArea, placemark.country];
            NSLog(@"Team Place Location : %@",self.teamPlaceMark);
        } else {
            NSLog(@"Fail to find place : %@", error.debugDescription);
        }
    } ];
}

#pragma mark -

- (BOOL)validateInputs {
    BOOL valid = YES;
    valid = valid && (self.teamName.length != 0);
    valid = valid && (self.teamImage != nil);
    valid = valid && (self.teamPlaceMark.length != 0);
    
    return valid;
}

- (void)createTeam {
    if (![self validateInputs]) {
        //TODO : Highlight the specific error fields
        [AlertView showAlert:NSLocalizedString(KAppName, nil) message:NSLocalizedString(@"Some required fields are missing", nil)];
        return;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:self.teamName forKey:@"teamName"];
    [parameters setValue:[NSString stringWithFormat:@"%f",self.currentLocation.coordinate.latitude] forKey:@"locationLatitude"];
    [parameters setValue:[NSString stringWithFormat:@"%f",self.currentLocation.coordinate.longitude] forKey:@"locationLongtitude"];
    [parameters setValue:self.teamPlaceMark forKey:@"teamLocation"];
    
    [[ServiceHandler sharedInstance] createTeam:parameters image:self.teamImage completion:^(id result, NSError *error) {
        if (error) {
            // Test workaround need proper handling
             if (error.code == 10) {
                 [AlertView showAlert:@"Error" message:@"Session Timeout" completionHandler:^(NSInteger buttonIndex, UIAlertController *alertController) {
                     [UserDefaultsWrapper setUserLoginedStatus:NO];
                     [NotificationObserver postNotification:KLoginNotification];
                 }];
             } else {
                 [AlertView showError:error];
             }
        } else {
            [AlertView showAlert:KAppName message:NSLocalizedString(@"Successfully create a Team", nil)];
            
            [UserDefaultsWrapper setTeamStatus:YES];
            [NotificationObserver postNotification:KJoinTeamNotification];
        }
    }];
}

#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error  {
    NSLog(@"CLLocationManager didFailWithError : %@", error);
//    [AlertView showAlert:@"Error" message:@"Failed to Get Your Location"];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation   {
    NSLog(@"CLLocationManager didUpdateToLocation: %@", newLocation);
    self.currentLocation = newLocation;
    [self.locationManager stopUpdatingLocation];
    
    [self findPlaceForLocation];
}


@end
