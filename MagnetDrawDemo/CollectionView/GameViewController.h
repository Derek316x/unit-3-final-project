//
//  GameViewController.h
//  Santa
//

//  Copyright (c) 2015 Xiulan Shi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ThreeFingerDismissViewController.h"

@interface GameViewController : ThreeFingerDismissViewController


@property (nonatomic) BOOL isOrientationSet;
@property AVAudioPlayer *backgroundMusicPlayer;

@end
