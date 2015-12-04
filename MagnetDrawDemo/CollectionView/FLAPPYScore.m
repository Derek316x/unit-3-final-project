//
//  Score.m
//  spritybird
//
//  Created by Alexis Creuzot on 16/02/2014.
//  Copyright (c) 2014 Alexis Creuzot. All rights reserved.
//

#import "FLAPPYScore.h"

@implementation FLAPPYScore

+ (void)registerScore:(NSInteger)score
{
    if(score > [FLAPPYScore bestScore]){
        [FLAPPYScore setBestScore:score];
    }
}

+ (void) setBestScore:(NSInteger) bestScore
{
    [[NSUserDefaults standardUserDefaults] setInteger:bestScore forKey:kBestScoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSInteger) bestScore
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kBestScoreKey];
}

@end
