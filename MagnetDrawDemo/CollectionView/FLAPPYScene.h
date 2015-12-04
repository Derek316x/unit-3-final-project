//
//  BouncingScene.h
//  Bouncing
//
//  Created by Seung Kyun Nam on 13. 7. 24..
//  Copyright (c) 2013년 Seung Kyun Nam. All rights reserved.
//

#import <objc/runtime.h>
#import <SpriteKit/SpriteKit.h>
#import "MagnetManager.h"


@protocol SceneDelegate <NSObject>
- (void) eventStart;
- (void) eventPlay;
- (void) eventWasted;
@end

@interface FLAPPYScene : SKScene<SKPhysicsContactDelegate>

@property (unsafe_unretained,nonatomic) id<SceneDelegate> delegate;
@property (nonatomic) NSInteger score;

@property (nonatomic) MagnetManager *manager;


@property BOOL gameStarted;


- (void) startGame;

@end
