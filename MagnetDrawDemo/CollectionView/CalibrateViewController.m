//
//  CalibrateViewController.m
//  Sprite Kit Pong
//
//  Created by Z on 11/22/15.
//  Copyright © 2015 Božidar Ševo. All rights reserved.
//

#import "CalibrateViewController.h"
#import "MagnetManager.h"

@interface CalibrateViewController ()

@property (nonatomic) MagnetManager *manager;

@property (nonatomic) BOOL isBottomSet;
@property (nonatomic) BOOL isTopSet;

@end

@implementation CalibrateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [MagnetManager sharedManager];
    [self.manager setup];
    self.isBottomSet = false;
    self.isTopSet = false;
}

- (IBAction)topButtonTapped:(UIButton *)sender {
    self.manager.topCalibrationVal = self.manager.heading.x;
    NSLog(@"Top calibration value set to: %f",self.manager.topCalibrationVal);
    self.isTopSet = true;
    [self dismissCalibrateVC];
}

- (IBAction)bottomButtonTapped:(UIButton *)sender {
    self.manager.bottomCalibrationVal = self.manager.heading.x;
    NSLog(@"Bottom calibration value set to: %f",self.manager.bottomCalibrationVal);
    self.isBottomSet = true;
    [self dismissCalibrateVC];
}

-(void)dismissCalibrateVC{
    if (self.isBottomSet == true && self.isTopSet == true) {
        
        self.manager.isTopBottomCalibrated = true;
         [self dismissViewControllerAnimated:YES completion:^{
             self.manager.isTopBottomCalibrated = true;
         }];
    }
}


@end
