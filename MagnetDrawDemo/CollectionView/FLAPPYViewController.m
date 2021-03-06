//
//  ViewController.m
//  spritybird
//
//  Created by Alexis Creuzot on 09/02/2014.
//  Copyright (c) 2014 Alexis Creuzot. All rights reserved.
//




#import "FLAPPYViewController.h"
#import "FLAPPYScore.h"
#import "MagnetManager.h"

@interface FLAPPYViewController ()
@property (weak,nonatomic) IBOutlet SKView * gameView;
@property (weak,nonatomic) IBOutlet UIView * getReadyView;

@property (weak,nonatomic) IBOutlet UIView * gameOverView;
@property (weak,nonatomic) IBOutlet UIImageView * medalImageView;
@property (weak,nonatomic) IBOutlet UILabel * currentScore;
@property (weak,nonatomic) IBOutlet UILabel * bestScoreLabel;

@end

@implementation FLAPPYViewController
{
    FLAPPYScene * scene;
    UIView * flash;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
	// Configure the view.
    //self.gameView.showsFPS = YES;
    //self.gameView.showsNodeCount = YES;
    
    // Create and configure the scene.
    scene = [FLAPPYScene sceneWithSize:self.gameView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.delegate = self;
    
    // Present the scene
    self.gameOverView.alpha = 0;
    self.gameOverView.transform = CGAffineTransformMakeScale(.9, .9);
    [self.gameView presentScene:scene];
    
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


- (BOOL)prefersStatusBarHidden
{
    return YES;
}

#pragma mark - Bouncing scene delegate

- (void)eventStart
{
    [UIView animateWithDuration:.2 animations:^{
        self.gameOverView.alpha = 0;
        self.gameOverView.transform = CGAffineTransformMakeScale(.8, .8);
        flash.alpha = 0;
        self.getReadyView.alpha = 1;
    } completion:^(BOOL finished) {
        [flash removeFromSuperview];

    }];
}

- (void)eventPlay
{
    [UIView animateWithDuration:.5 animations:^{
        self.getReadyView.alpha = 0;
    }];
}

- (void)eventWasted
{
    flash = [[UIView alloc] initWithFrame:self.view.frame];
    flash.backgroundColor = [UIColor whiteColor];
    flash.alpha = .9;
    [self.gameView insertSubview:flash belowSubview:self.getReadyView];
    
    [self shakeFrame];
    
    [UIView animateWithDuration:.6 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        
        // Display game over
        flash.alpha = .4;
        self.gameOverView.alpha = 1;
        self.gameOverView.transform = CGAffineTransformMakeScale(1, 1);
        
        // Set medal
        if(scene.score >= 40){
            self.medalImageView.image = [UIImage imageNamed:@"medal_platinum"];
        }else if (scene.score >= 30){
            self.medalImageView.image = [UIImage imageNamed:@"medal_gold"];
        }else if (scene.score >= 20){
            self.medalImageView.image = [UIImage imageNamed:@"medal_silver"];
        }else if (scene.score >= 10){
            self.medalImageView.image = [UIImage imageNamed:@"medal_bronze"];
        }else{
            self.medalImageView.image = nil;
        }
        
        // Set scores
        self.currentScore.text = [NSString stringWithFormat:@"%li",scene.score];
        self.bestScoreLabel.text = [NSString stringWithFormat:@"%li",(long)[FLAPPYScore bestScore]];
        
    } completion:^(BOOL finished) {
        flash.userInteractionEnabled = NO;
    }];
    
}

- (void) shakeFrame
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setDuration:0.05];
    [animation setRepeatCount:4];
    [animation setAutoreverses:YES];
    [animation setFromValue:[NSValue valueWithCGPoint:
                             CGPointMake([self.view  center].x - 4.0f, [self.view  center].y)]];
    [animation setToValue:[NSValue valueWithCGPoint:
                           CGPointMake([self.view  center].x + 4.0f, [self.view  center].y)]];
    [[self.view layer] addAnimation:animation forKey:@"position"];
}


-(void)setupBackgroundMusic{
    NSString *pathForMP3 = [[NSBundle mainBundle] pathForResource: @"Nin10day" ofType: @"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:pathForMP3];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [self.backgroundMusicPlayer setVolume:0.25];
    [self.backgroundMusicPlayer play];
}

@end
