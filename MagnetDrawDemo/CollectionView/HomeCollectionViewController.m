//
//  HomeCollectionViewController.m
//  CollectionView
//
//  Created by Xiulan Shi on 11/18/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "HomeCollectionViewController.h"
#import "HomeCollectionViewCell.h"
#import "DetailViewController.h"
#import "CalibrateViewController.h"

#import "UIImage+animatedGIF.h"
#import "UINavigationController+Orientation.h"

#import "SKPViewController.h" //pong
#import "GameViewController.h" //jump
#import "FLAPPYViewController.h" //flappy

#import <AVFoundation/AVFoundation.h>

#import "CollectionView-Swift.h"

@interface HomeCollectionViewController ()

@property NSMutableArray *dataArray;
@property AVAudioPlayer *backgroundMusicPlayer;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setBackgroundImage];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.isMovingToParentViewController == NO)
    {
        // we're already on the navigation stack
        // another controller must have been popped off
        
        [self setupBackgroundMusic];
        
    }
}

-(void)setBackgroundImage{
    NSString *pathForGif = [[NSBundle mainBundle] pathForResource: @"BackgroundWarp" ofType: @"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile: pathForGif];
    self.backgroundImageView.image = [UIImage animatedImageWithAnimatedGIFData:gifData];
    
    
    UIImageView *image =[[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, 678.0/3.3, 136.0/3.3)];
    image.image=[UIImage imageNamed:@"pencrafttitle.png"];
    [self.view addSubview:image];
    
}

-(void)setupBackgroundMusic{
    NSString *pathForMP3 = [[NSBundle mainBundle] pathForResource: @"8BitBomber" ofType: @"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:pathForMP3];
    self.backgroundMusicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:soundUrl error:nil];
    [self.backgroundMusicPlayer play];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
                                
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.backgroundMusicPlayer stop];

    if (indexPath.row == 0) { //pong
        SKPViewController *pongVC = [[SKPViewController alloc] init];
        [self.navigationController presentViewController:pongVC animated:YES completion:^{}];
    }
    else if (indexPath.row == 1){//jump
        GameViewController *jumpVC = [[GameViewController alloc] init];
        [self presentViewController:jumpVC animated:YES completion:nil];
    }
    else if (indexPath.row == 2) { //flappy
        FLAPPYViewController *flappyVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"FlappyID"];
        [self presentViewController:flappyVC animated:YES completion:nil];
    }
    else if (indexPath.row == 3) { //calibrate
        [self showCalibrateViewController];
    }
}

-(void)showCalibrateViewController{
    
    CalibrateViewController *calibrateVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CalibrateID"];
    
    [self presentViewController:calibrateVC animated:YES completion:nil];
    
}

- (BOOL)shouldAutorotate{
    //returns true if want to allow orientation change
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    //decide number of origination tob supported by Viewcontroller.
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
