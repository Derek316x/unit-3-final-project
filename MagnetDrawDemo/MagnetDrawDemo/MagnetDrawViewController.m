//
//  MagnetDrawViewController.m
//  MagnetDrawDemo
//
//  Created by Z on 11/10/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

#import "MagnetDrawViewController.h"
#import "MagneticCalibrationData.h"
#import "MagnetVector.h"

@interface MagnetDrawViewController ()

@property (nonatomic) CLLocationManager *locationManager;
@property (nonatomic) CLHeading *heading;

@property (weak, nonatomic) IBOutlet UILabel *xLabel;
@property (weak, nonatomic) IBOutlet UILabel *yLabel;
@property (weak, nonatomic) IBOutlet UILabel *zLabel;

@property (nonatomic) MagnetVector *vector;
@property (nonatomic) MagneticCalibrationData *calibrationData;

@end

@implementation MagnetDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self checkLocationServicesAuthorization];
    
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
    
    //initialize calibration data
    self.calibrationData = [[MagneticCalibrationData alloc] init];
    
    //initialize vector
    self.vector = [[MagnetVector alloc] init];
}

-(void)checkLocationServicesAuthorization{
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
    }
}

// This delegate method is invoked when the location manager has heading data.
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)heading {
    
    self.heading = heading;
    
    // Update the labels with the raw x, y, and z values.
    NSString *Xstring = [NSString stringWithFormat:@"%.1f", heading.x];
    NSString *Ystring = [NSString stringWithFormat:@"%.1f", heading.y];
    NSString *Zstring = [NSString stringWithFormat:@"%.1f", heading.z];
    
    self.xLabel.text = Xstring;
    self.yLabel.text = Ystring;
    self.zLabel.text = Zstring;
    
    // Compute and display the magnitude (size or strength) of the vector.
    //      magnitude = sqrt(x^2 + y^2 + z^2)
    CGFloat magnitude = sqrt(heading.x*heading.x + heading.y*heading.y + heading.z*heading.z);
    NSString *magnitudeString = [NSString stringWithFormat:@"%.1f", magnitude];
    
    CGFloat rawHeadingAngle = [self rawHeadingAngle];
    
    NSLog(@"X = %@, Y = %@, Z = %@, Magnitude = %@, angle = %f", Xstring,Ystring,Zstring,magnitudeString,rawHeadingAngle);
    
    self.vector.magnitude = magnitude;
    self.vector.direction = rawHeadingAngle;
    
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

-(CGFloat)rawHeadingAngle{
    CGFloat xVec = [[self class] degreesToRadians:self.heading.x];
    CGFloat yVec = [[self class] degreesToRadians:self.heading.y];
  //  CGFloat zVec = [[self class] degreesToRadians:self.heading.z];
    
    CGFloat rawHeading = [self rawHeadingFromX:xVec Y:yVec];
   // CGFloat rawHeadingAngle = -[[self class] degreesToRadians:rawHeading];
    return rawHeading;
}

- (CGFloat) rawHeadingFromX:(CGFloat)xVec Y:(CGFloat)yVec{
    /*
     to obtain this X and Y we really need to use the original mag XYZ and do some kind of matrix multiplication with the rotation matrix for the device.
     Here we are only using the original X and Y values, so this only works if the device is held flat.
     */
    
    //http://stackoverflow.com/questions/11383968/which-ios-class-code-returns-the-magnetic-north/11384054#11384054
    //http://www51.honeywell.com/aero/common/documents/myaerospacecatalog-documents/Defense_Brochures-documents/Magnetic__Literature_Application_notes-documents/AN203_Compass_Heading_Using_Magnetometers.pdf
    
    CGFloat rawHeading = 0;
    if (yVec > 0) rawHeading = 90.0 - atan(xVec/yVec)*180.0/M_PI;
    if (yVec < 0) rawHeading = 270.0 - atan(xVec/yVec)*180.0/M_PI;
    if (yVec == 0 && xVec < 0) rawHeading = 180.0;
    if (yVec == 0 && xVec > 0) rawHeading = 0.0;
    rawHeading -=90;
    return rawHeading;
}


#pragma mark - angle conversions
+ (CGFloat) degreesToRadians:(CGFloat) degrees {return degrees * M_PI / 180;};
+ (CGFloat) radiansToDegrees:(CGFloat) radians {return radians * 180/M_PI;};

- (IBAction)calibrateLeft:(UIButton *)sender {
    
    
}

- (IBAction)calibrateMiddle:(UIButton *)sender {
}

- (IBAction)calibrateRight:(UIButton *)sender {
}

- (IBAction)calibrateBottom:(UIButton *)sender {
}




@end
