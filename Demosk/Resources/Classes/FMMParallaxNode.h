//
//  FMMParallaxNode.h
//  SpaceShooter
//
//  Created by Tony Dahbura on 9/9/13.
//  Copyright (c) 2013 fullmoonmanor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FMMParallaxNode : SKNode

- (instancetype)initWithBackground:(NSString *)file size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed;
- (instancetype)initWithBackgrounds:(NSArray *)files size:(CGSize)size pointsPerSecondSpeed:(float)pointsPerSecondSpeed;
- (void)randomizeNodesPositions;
- (void)update:(NSTimeInterval)currentTime;


@end
