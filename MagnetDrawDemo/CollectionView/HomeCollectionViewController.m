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


#import "CollectionView-Swift.h"

@interface HomeCollectionViewController ()

@property NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [[NSMutableArray alloc] init];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    self.backgroundImageView.image = [UIImage animatedImageWithAnimatedGIFURL:[NSURL URLWithString:@"http://i.imgur.com/RuJYgPu.gif"]];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
                                
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 0) { //pong
        SKPViewController *pongVC = [[SKPViewController alloc] init];
        [self.navigationController presentViewController:pongVC animated:YES completion:^{}];
    }
    else if (indexPath.row == 1){//drop charge
        
    }
    else if (indexPath.row == 2){//jump
        
        GameViewController *jumpVC = [[GameViewController alloc] init];
        [self.navigationController pushViewController:jumpVC animated:YES];
    }
    else if (indexPath.row == 3){//space invaders

    }
    
    if (indexPath.row == 4) { //calibrate
        [self showCalibrateViewController];
    }
}

-(void)showCalibrateViewController{
    
    CalibrateViewController *calibrateVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CalibrateID"];
    
    [self presentViewController:calibrateVC animated:YES completion:nil];
    
}

- (BOOL)shouldAutorotate{
    //returns true if want to allow orientation change
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    //decide number of origination tob supported by Viewcontroller.
    return UIInterfaceOrientationMaskLandscapeRight;
}

@end
