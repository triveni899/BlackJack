//
//  GameScreen.m
//  breakout
//
//  Created by Triveni Banpela on 2/15/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

#import "GameScreen.h"

@implementation GameScreen
@synthesize paddle, ball;
@synthesize timer;
@synthesize brick;
@synthesize brick_array;
@synthesize ScoreVal;
@synthesize gameOver;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)createPlayField
{
    self.brick_array = [[NSMutableArray alloc] init];
    int x=20, y=40;
    int index = 0;
    
   
    for(int i=0;i<10;i++)
    {
        for(int j=0; j<5;j++)
        {
            brick = [[UIView alloc] initWithFrame:CGRectMake(x, y,60,15)];
            [self.brick_array addObject:brick];
            [self addSubview:brick_array[index]];
           // [brick_array[index] setBackgroundColor:[[UIColor alloc] initWithRed:arc4random()%256/256.0 green:arc4random()%256/256.0 blue:arc4random()%256/256.0 alpha:1.0]];
            [brick_array[index] setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"brick.png"]] ];
            x=x+60;
            index++;
        }
        x=20;y=y+20;
        
    }
        
	paddle = [[UIView alloc] initWithFrame:CGRectMake(20, 40, 60, 10)];
	[self addSubview:paddle];
	[paddle setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"paddle.png"]]];
    CGPoint p = {50,500};
    [paddle setCenter:p];
    
    
	
	ball = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 15, 15)];
	[self addSubview:ball];
	[ball setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"green.png"]]];
    CGPoint q = {50,490};
    [ball setCenter:q];
	
	dx = 10;
	dy = 10;
    score = 50;
    ScoreVal.text = [NSString stringWithFormat:@"%d", score];
    self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wall3.jpg"]];
    //[self playMusic];
    
}


- (void)playMusic {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"wallAndPaddle" ofType:@"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: filePath];
    
    musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    //musicPlayer.numberOfLoops = -1; //infinite replays
    
    
    
    [musicPlayer prepareToPlay];
    [musicPlayer play];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	for (UITouch *t in touches)
	{
		CGPoint p = [t locationInView:self];
        p.y=500; //for making it fixed
		[paddle setCenter:p];
	}
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	[self touchesBegan:touches withEvent:event];
}

-(IBAction)startAnimation:(id)sender
{
	timer = [NSTimer scheduledTimerWithTimeInterval:.1	target:self selector:@selector(timerEvent:) userInfo:nil repeats:YES];

}

-(IBAction)stopAnimation:(id)sender
{
	[timer invalidate];
}

-(void)timerEvent:(id)sender
{
	CGRect bounds = [self bounds];
	
	// NSLog(@"Timer event.");
	CGPoint p = [ball center];

	if ((p.x + dx) < 0)
		dx = -dx;
	
	if ((p.y + dy) < 0)
		dy = -dy;
	
	if ((p.x + dx) > bounds.size.width)
		dx = -dx;
	
	if ((p.y + dy) > bounds.size.height)
		dy = -dy;
	
	p.x += dx;
	p.y += dy;
	[ball setCenter:p];
	
	// Now check to see if we intersect with paddle.  If the movement
	// has placed the ball inside the paddle, we reverse that motion
	// in the Y direction.
	if (CGRectIntersectsRect([ball frame], [paddle frame]))
	{
		dy = -dy;
		p.y += 2*dy;
		[ball setCenter:p];
	}
   for(UIView *tempbrick in brick_array)
   {
       if (CGRectIntersectsRect(ball.frame,tempbrick.frame))
       {
           dy = -dy;
           p.y += 2*dy;
           [ball setCenter:p];
           tempbrick.hidden = YES;
           [self playMusic];
       }
   }
    if(ball.center.y > paddle.center.y)
       {
         
       /* UIImageView *brickImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gameover.jpg"]];
           CGPoint q = {100,200};
           [brickImage setCenter:q];
           [self addSubview:brickImage]; */
         self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"over.jpg"]];
            [timer invalidate];
           
          
       }
    

}
/*

-(void)exitgame{
    
    for(UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
} */

@end
