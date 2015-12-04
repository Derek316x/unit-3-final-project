//
//  ThreeFingerDismissViewController.m
//  CollectionView
//
//  Created by Z on 12/3/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "ThreeFingerDismissViewController.h"

@interface ThreeFingerDismissViewController ()

@end

@implementation ThreeFingerDismissViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (touches.count == 3) {
        
        NSLog(@"%lu active touches",[[event touchesForView:self.view] count]);
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
}

@end
