//
//  GameScreen.h
//  breakout
//
//  Created by Triveni Banpela on 2/15/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

//make it cocoatouch.h file

#import <UIKit/UIKit.h>

@interface GameScreen : UIView
{
    float dx, dy;  // Ball motion
}
@property (nonatomic, strong) UIView *paddle;
@property (nonatomic, strong) UIView *brick;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *brick_array;



-(void)createPlayField;

@end
