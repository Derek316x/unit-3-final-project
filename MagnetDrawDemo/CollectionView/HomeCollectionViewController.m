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

#import "SKPViewController.h"

#import "CollectionView-Swift.h"

@interface HomeCollectionViewController ()

@property NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;

@end

@implementation HomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
   // [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
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
    
    // Configure the cell
    
    cell.cellImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%li", (long)indexPath.row]];
                                
    return cell;
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    if (indexPath.row == 0) { //pong
        SKPViewController *pongVC = [[SKPViewController alloc] init];
        [self.navigationController presentViewController:pongVC animated:YES completion:^{}];
    }
    
    else if (indexPath.row == 1){//drop charge
        
    }
    else if (indexPath.row == 2){//space invaders
        
    }
    else if (indexPath.row == 3){//jump
        GameViewController *gameVC = [[GameViewController alloc] init];
        
    }
    
    if (indexPath.row == 4) { //calibrate
        [self pongCalibrateTopBottom];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

-(void)pongCalibrateTopBottom{
    
    CalibrateViewController *calibrateVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CalibrateID"];
    
    
    [self presentViewController:calibrateVC animated:YES completion:nil];
    
//    UIViewController *top = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
//    [top presentViewController:calibrateVC animated:YES completion: nil];
    
}

@end
