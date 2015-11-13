//
//  MagnetVector.m
//  MagnetDrawDemo
//
//  Created by Z on 11/12/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

#import "MagnetVector.h"

@implementation MagnetVector


-(id)initWithMagnitude:(CGFloat)magnitude AndDirection:(CGFloat)direction{
    
    self = [super init];
    
    self.magnitude = magnitude;
    self.direction = direction;
    
    return self;
}

@end
