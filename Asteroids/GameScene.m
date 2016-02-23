//
//  GameScene.m
//  Asteroids
//
//  Created by Triveni Banpela on 2/22/16.
//  Copyright (c) 2016 Triveni Banpela. All rights reserved.
//

#import "GameScene.h"
@import CoreMotion;


#define kNumAsteroids 15
#define ASTEROID_SPEED 1

int _lives;

@implementation GameScene
{
    SKSpriteNode *_ship;
    CMMotionManager *_motionManager;
    NSMutableArray *_asteroids;
    int _nextAsteroid;
    double _nextAsteroidSpawn;
    NSMutableArray *_shipLasers;
    int _nextShipLaser;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky.jpg"]];
        self.backgroundColor = [SKColor blackColor];
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        /*
         
         SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"skyl.png"];
         [self addChild:bgImage];
         */
        
        
        _ship = [SKSpriteNode spriteNodeWithImageNamed:@"rocket3.png"];
        _ship.position = CGPointMake(self.frame.size.width*0.1,CGRectGetMidY(self.frame));
        
        
        _ship.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_ship.frame.size];
        _ship.physicsBody.dynamic = YES;
        _ship.physicsBody.affectedByGravity = NO;
        _ship.physicsBody.mass = 0.02;
        
        [self addChild:_ship];
        
#pragma mark - TBD - Setup the asteroids
        _asteroids = [[NSMutableArray alloc] initWithCapacity:kNumAsteroids];
        
        for (int i = 0; i < 15; ++i) {
            SKSpriteNode *asteroid = [SKSpriteNode spriteNodeWithImageNamed:@"asteroid3"];
            asteroid.hidden = YES;
            [asteroid setXScale:0.5];
            [asteroid setYScale:0.5];
            [_asteroids addObject:asteroid];
            [self addChild:asteroid];
        }
        
        //lasers
        _shipLasers = [[NSMutableArray alloc] initWithCapacity:5];
        for (int i = 0; i < 5; ++i) {
            SKSpriteNode *shipLaser = [SKSpriteNode spriteNodeWithImageNamed:@"laser_red"];
            shipLaser.hidden = YES;
            [_shipLasers addObject:shipLaser];
            [self addChild:shipLaser];
        }
        
        _motionManager = [[CMMotionManager alloc] init];
        [self startTheGame];
    }
    
    return self;
}
-(void)startTheGame
{
    _nextAsteroidSpawn = 0;
    
    for (SKSpriteNode *asteroid in _asteroids) {
        asteroid.hidden = YES;
    }
    _ship.hidden = NO;
    //reset ship position for new game
    _ship.position = CGPointMake(self.frame.size.width * 0.1, CGRectGetMidY(self.frame));
    [self startMonitoringAcceleration];
    
    
    
}
-(void)startMonitoringAcceleration
{
    if (_motionManager.accelerometerAvailable) {
        [_motionManager startAccelerometerUpdates];
        NSLog(@"accelerometer updates on...");
    }
    
}

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    /* SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
     
     myLabel.text = @"Hello, World!";
     myLabel.fontSize = 45;
     myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
     CGRectGetMidY(self.frame));
     
     [self addChild:myLabel];*/
    //self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sky3.jpg"]];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    /*for (UITouch *touch in touches) {
     CGPoint location = [touch locationInNode:self];
     
     SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithImageNamed:@"Spaceship"];
     
     sprite.xScale = 0.5;
     sprite.yScale = 0.5;
     sprite.position = location;
     
     SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
     
     [sprite runAction:[SKAction repeatActionForever:action]];
     
     [self addChild:sprite];
     }*/
    
    /* Called when a touch begins */
    //1
    SKSpriteNode *shipLaser = [_shipLasers objectAtIndex:_nextShipLaser];
    _nextShipLaser++;
    if (_nextShipLaser >= _shipLasers.count) {
        _nextShipLaser = 0;
    }
    
    //2
    shipLaser.position = CGPointMake(_ship.position.x+shipLaser.size.width/2,_ship.position.y+0);
    shipLaser.hidden = NO;
    [shipLaser removeAllActions];
    
    //3
    CGPoint location = CGPointMake(self.frame.size.width, _ship.position.y);
    SKAction *laserMoveAction = [SKAction moveTo:location duration:0.5];
    //4
    SKAction *laserDoneAction = [SKAction runBlock:(dispatch_block_t)^() {
        //NSLog(@"Animation Completed");
        shipLaser.hidden = YES;
    }];
    
    //5
    SKAction *moveLaserActionWithDone = [SKAction sequence:@[laserMoveAction,laserDoneAction]];
    //6
    [shipLaser runAction:moveLaserActionWithDone withKey:@"laserFired"];
    
}

- (void)updateShipPositionFromMotionManager
{
    CMAccelerometerData* data = _motionManager.accelerometerData;
    if (fabs(data.acceleration.x) > 0.2) {
        [_ship.physicsBody applyForce:CGVectorMake(0.0, 40.0 * data.acceleration.x)];
    }
}

- (float)randomValueBetween:(float)low andValue:(float)high {
    return (((float) arc4random() / 0xFFFFFFFFu) * (high - low)) + low;
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    [self updateShipPositionFromMotionManager];
    double curTime = CACurrentMediaTime();
    if (curTime > _nextAsteroidSpawn)
    {
        float randSecs = [self randomValueBetween:0.20 andValue:1.0];
        _nextAsteroidSpawn = randSecs + curTime;
        
        float randY = [self randomValueBetween:0.0 andValue:self.frame.size.height];
        float randDuration = [self randomValueBetween:2.0 andValue:10.0];
        
        SKSpriteNode *asteroid = [_asteroids objectAtIndex:_nextAsteroid];
        _nextAsteroid = (_nextAsteroid+1) % _asteroids.count;
        
        [asteroid removeAllActions];
        asteroid.position = CGPointMake(self.frame.size.width+asteroid.size.width/2, randY);
        asteroid.hidden = NO;
        
        CGPoint location = CGPointMake(-self.frame.size.width-asteroid.size.width, randY);
        SKAction *moveAction = [SKAction moveTo:location duration:randDuration];
        SKAction *doneAction = [SKAction runBlock:(dispatch_block_t)^() {
            //NSLog(@"Animation Completed");
            asteroid.hidden = YES;
        }];
        SKAction *moveAsteroidActionWithDone = [SKAction sequence:@[moveAction, doneAction ]];
        [asteroid runAction:moveAsteroidActionWithDone withKey:@"asteroidMoving"];

    }
    
    
    //check for laser collision with asteroid
    for (SKSpriteNode *asteroid in _asteroids) {
        if (asteroid.hidden) {
            continue;
        }
        for (SKSpriteNode *shipLaser in _shipLasers) {
            if (shipLaser.hidden) {
                continue;
            }
            
            if ([shipLaser intersectsNode:asteroid]) {
                shipLaser.hidden = YES;
                asteroid.hidden = YES;
                
                NSLog(@"you just destroyed an asteroid");
                continue;
            }
        }
        if ([_ship intersectsNode:asteroid]) {
            if(abs((_ship.position.y) - (asteroid.position.y)) > asteroid.frame.size.height/2 + _ship.frame.size.height/2)
            {
                continue;
            }
            
            
            asteroid.hidden = YES;
            SKAction *blink = [SKAction sequence:@[[SKAction fadeOutWithDuration:0.1],
                                                   [SKAction fadeInWithDuration:0.1]]];
            SKAction *blinkForTime = [SKAction repeatAction:blink count:4];
            [_ship runAction:blinkForTime];
            _lives--;
            NSLog(@"your ship has been hit! %d:%d", (int)_ship.position.y, (int)asteroid.position.y);
        }
    }
    
}

@end
