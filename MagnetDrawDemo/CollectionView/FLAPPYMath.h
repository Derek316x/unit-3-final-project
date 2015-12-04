//
//  Math.h
//  spritybird
//
//  Created by Alexis Creuzot on 09/02/2014.
//  Copyright (c) 2014 Alexis Creuzot. All rights reserved.
//

#include <UIKit/UIKit.h>

@interface FLAPPYMath : NSObject

+ (void) setRandomSeed:(unsigned int) seed;
+ (float) randomFloatBetween:(float) min and:(float) max;

@end
