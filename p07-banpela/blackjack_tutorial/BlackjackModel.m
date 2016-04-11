//
//  BlackjackModel.m
//  blackjack_tutorial
//

//

#import "BlackjackModel.h"

@implementation BlackjackModel

@synthesize deck = _deck, dealerHand=_dealerHand, playerHand=_playerHand, totalPlays=_totalPlays;

static BlackjackModel* blackjackModel = nil;

-(id) init {
    if ((self = [super init])){
        _deck = [[Deck alloc] init];
        _playerHand = [[Hand alloc] init];
        _dealerHand = [[Hand alloc] init];
        _dealerHand.handClosed = YES;
        _totalPlays = 0;
    }
    return (self);
}

-(void)setup
{
    //deal cards
    [self playerHandDraws];
    [self dealerHandDraws];
    
    [self playerHandDraws];
    [self dealerHandDraws];
    
}

-(void)dealerHandDraws
{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"dealerHand"];
}

-(void)playerHandDraws
{
    [self willChangeValueForKey:@"playerHand"];
    [_playerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"playerHand"];
    [self EndGameIfPlayerIsBust];
}

-(void)dealerStartsTurn{
   [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand setHandClosed:NO];
  [self didChangeValueForKey:@"dealerHand"];
}

-(void)playerStands
{
    [self dealerStartsTurn];
    [self dealerPlays];
}

-(void) EndGameIfPlayerIsBust
{
    if (_playerHand.getPipValue > 21)
        [self gameEnds:Dealer];
}

-(void) gameEnds:(Winner) winner;
{
    self.totalPlays = self.totalPlays+1;
}

-(void) resetGame;
{
    _deck = nil;
    _playerHand = nil;
    _dealerHand = nil;
    _deck = [[Deck alloc] init];
    _playerHand = [[Hand alloc] init];
    _dealerHand = [[Hand alloc] init];
    _dealerHand.handClosed = YES;
    [self setup];
}

-(void)dealerPlays
{
    while (_dealerHand.getPipValue < 17)
    {
        [self dealerHandDraws];
        
    }
    
    if (_dealerHand.getPipValue > 21)
        [self gameEnds:Player ];
    else if (_dealerHand.getPipValue > _playerHand.getPipValue)
        [self gameEnds:Dealer];
    else
        [self gameEnds:Draw ];
}

+(BlackjackModel *) getBlackjackModel{
    if (blackjackModel == nil){
        blackjackModel = [[BlackjackModel alloc] init];
    }
    return blackjackModel;
}

@end
