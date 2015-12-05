//
//  HomeCollectionViewCell.m
//  CollectionView
//
//  Created by Xiulan Shi on 11/18/15.
//  Copyright © 2015 Xiulan Shi. All rights reserved.
//

#import "HomeCollectionViewCell.h"

@implementation HomeCollectionViewCell

- (void)awakeFromNib {
    
    // background color
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    self.backgroundView = bgView;
    //self.backgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"blue"]];
    self.backgroundView.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:208.0/255.0 blue:0.0 alpha:1.0];
    
    // selected background
    UIView *selectedView = [[UIView alloc]initWithFrame:self.bounds];
    self.selectedBackgroundView = selectedView;
    self.selectedBackgroundView.backgroundColor = [UIColor redColor];
    //self.selectedBackgroundView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pink"]];
    
}

@end
