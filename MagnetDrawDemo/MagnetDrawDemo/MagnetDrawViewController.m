//
//  MagnetDrawViewController.m
//  MagnetDrawDemo
//
//  Created by Z on 11/10/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

#import "MagnetDrawViewController.h"

@interface MagnetDrawViewController ()

@property (nonatomic) CLLocationManager *locationManager;

@end

@implementation MagnetDrawViewController

struct MagneticCalibrationData{
    double TopLeft;
    double TopMiddle;
    double TopRight;
    double BottomMiddle;
};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // check if the hardware has a compass
    if ([CLLocationManager headingAvailable] == NO) {
        
        //alert user that there is no compass
        UIAlertController *noCompassAlert = [UIAlertController alertControllerWithTitle:@"No Compass" message:@"This device is not able to detect magnetic fields" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:noCompassAlert animated:YES completion:^{}];
        
    
    } else {

        //check if location services are authorized
        //alert user that location services are disabled
        if (([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted) ||
            ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusRestricted)){
            UIAlertController *noLocationServicesAlert = [UIAlertController alertControllerWithTitle:@"Location Services Disabled" message:@"Enable location services to detect magnetic fields" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:noLocationServicesAlert animated:YES completion:^{}];
        }
        
        // setup the location manager
        self.locationManager = [[CLLocationManager alloc] init];
        
        // setup delegate callbacks
        self.locationManager.delegate = self;
        
        //request permission for the app to use location services
        if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
             [self.locationManager requestWhenInUseAuthorization];
        }
        
        // heading service configuration
        self.locationManager.headingFilter = kCLHeadingFilterNone;
        
        // start the compass
        [self.locationManager startUpdatingHeading];
    }
}

// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    // Update the labels with the raw x, y, and z values.
    NSString *Xstring = [NSString stringWithFormat:@"%.1f", heading.x];
    NSString *Ystring = [NSString stringWithFormat:@"%.1f", heading.y];
    NSString *Zstring = [NSString stringWithFormat:@"%.1f", heading.z];
    
    // Compute and display the magnitude (size or strength) of the vector.
    //      magnitude = sqrt(x^2 + y^2 + z^2)
    CGFloat magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    NSString *magnitudeString = [NSString stringWithFormat:@"%.1f", magnitude];
    
    NSLog(@"X = %@, Y = %@, Z = %@, Magnitude = %@",Xstring,Ystring,Zstring,magnitudeString);
}

// This delegate method is invoked when the location managed encounters an error condition.
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([error code] == kCLErrorDenied) {
        // This error indicates that the user has denied the application's request to use location services.
        [manager stopUpdatingHeading];
    } else if ([error code] == kCLErrorHeadingFailure) {
        // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
    }
}
    



@end
