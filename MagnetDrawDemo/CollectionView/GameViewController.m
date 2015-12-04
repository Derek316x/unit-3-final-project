//
//  GameViewController.m
//  Santa
//
//  Created by Xiulan Shi on 11/30/15.
//  Copyright (c) 2015 Xiulan Shi. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"


#import "UINavigationController+Orientation.h"

@implementation GameViewController


-(void)loadView{
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    CGFloat height = MAX(bounds.size.height, bounds.size.width);
    CGFloat width = MIN(bounds.size.height, bounds.size.width);
    self.view = [[SKView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [GameScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFit;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isMovingToParentViewController == NO)
    {
        [self setupBackgroundMusic];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    [self.backgroundMusicPlayer stop];
}

- (BOOL)shouldAutorotate{
    //returns true if want to allow orientation change
    return YES;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

-(void)setupBackgroundMusic{
    NSString *pathForMP3 = [[NSBundle mainBundle] pathForResource: @"Struggle" ofType: @"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:pathForMP3];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [self.backgroundMusicPlayer play];
}

@end
