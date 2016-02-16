//
//  GameScreen.h
//  breakout
//
//  Created by Triveni Banpela on 2/15/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

//make it cocoatouch.h file

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface GameScreen : UIView
{
    int score;
    float dx, dy;  // Ball motion
    AVAudioPlayer *musicPlayer;
}
@property (nonatomic, strong) UIView *paddle;
@property (nonatomic, strong) UIView *brick;
@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSMutableArray *brick_array;
@property (nonatomic, strong) UILabel *gameOver;


@property (weak, nonatomic) IBOutlet UILabel *ScoreVal;

-(void)createPlayField;

@end
