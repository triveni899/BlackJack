//
//  BlackjackModel.m
//  blackjack_tutorial
//

//

#import "BlackjackModel.h"

@implementation BlackjackModel

@synthesize deck = _deck, dealerHand=_dealerHand, playerHand=_playerHand, AIplayerHand=_AIplayerHand,totalPlays=_totalPlays;
@synthesize Busted =_Busted;

@synthesize flag_player;

static BlackjackModel* blackjackModel = nil;

-(id) init {
    if ((self = [super init])){
        _deck = [[Deck alloc] init];
   
        
        _playerHand = [[Hand alloc] init];
        _AIplayerHand = [[Hand alloc] init];
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
    [self AIplayerHandDraws];
    [self dealerHandDraws];
    
    [self playerHandDraws];
    [self AIplayerHandDraws];
    [self dealerHandDraws];
    
}

-(void)dealerHandDraws
{
    [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"dealerHand"];
    [self setAIEngine];
}

-(void)playerHandDraws
{
    [self willChangeValueForKey:@"playerHand"];
    [_playerHand addCard:[_deck drawCard]];
    [self didChangeValueForKey:@"playerHand"];
    [self EndGameIfPlayerIsBust];
    [self setAIEngine];
}



-(void)AIplayerHandDraws
{
    if(count<=1)
    {
        [self willChangeValueForKey:@"AIplayerHand"];
        [_AIplayerHand addCard:[_deck drawCard]];
        [self didChangeValueForKey:@"AIplayerHand"];
        [self EndGameIfPlayerIsBust];
        
    }
    else
    {
    
        if((_AIplayerHand.getPipValue > _playerHand.getPipValue) && (_AIplayerHand.getPipValue > _dealerHand.getPipValue))
        {
            if(_AIplayerHand.getPipValue <21)
            {
                [self willChangeValueForKey:@"AIplayerHand"];
                [_AIplayerHand addCard:[_deck drawCard]];
                [self didChangeValueForKey:@"AIplayerHand"];
                [self EndGameIfAIPlayerIsBust];
            
            }
            
        }else
        {
            AIplayerstand=1;
            [self AIplayerStands];
        }
        
    }//else count ends
    count++;
    [self setAIEngine];
}


-(void)dealerStartsTurn{
   [self willChangeValueForKey:@"dealerHand"];
    [_dealerHand setHandClosed:NO];
  [self didChangeValueForKey:@"dealerHand"];
}


-(void)setAIEngine{
    
    AIplayerhand=_AIplayerHand.getPipValue;
    playerhand=_playerHand.getPipValue;
    dealerhand=_dealerHand.getPipValue;

}
-(void)playerStands
{
    playerstand=1;
    
    [self dealerStartsTurn];
    [self dealerPlays];
    
    
    [self setAIEngine];
}

-(void)AIplayerStands
{
     AIplayerstand = 1;
    
    if((playerstand==1) && (AIplayerstand == 1))
    {
        [self dealerStartsTurn];
        [self dealerPlays];
    }
    [self setAIEngine];
}

-(void) EndGameIfPlayerIsBust
{
    if (_playerHand.getPipValue > 21)
    {
        
        player_bflag=1;

        [self gameEnds:Dealer];
    }
     [self setAIEngine];
}

-(void) EndGameIfAIPlayerIsBust
{
    if (_AIplayerHand.getPipValue > 21)
    {
        AIplayer_bflag=1;
        [self gameEnds:Dealer];
    }
     [self setAIEngine];
}

-(void) gameEnds:(Winner) winner;
{
    self.totalPlays = self.totalPlays+1;
}

-(void) resetGame;
{
    _deck = nil;
    
    _playerHand = nil;
    _AIplayerHand = nil;
    _dealerHand = nil;
    _deck = [[Deck alloc] init];
    _playerHand = [[Hand alloc] init];
    _AIplayerHand = [[Hand alloc] init];
    _dealerHand = [[Hand alloc] init];
    _dealerHand.handClosed = YES;
    [self setup];
     [self setAIEngine];
}

-(void)dealerPlays
{
    while (_dealerHand.getPipValue < 17)
    {
        
        [self dealerHandDraws];
        
    }
    
    if (_dealerHand.getPipValue > 21)
    {
         dealer_bflag=1;
        if(_playerHand.getPipValue > _AIplayerHand.getPipValue)
        {
            player_wflag=1;
            [self gameEnds:Player];
        }else
        {
            AIplayer_wflag=1;
            [self gameEnds:AIPlayer];
        }
    }
    else if (_dealerHand.getPipValue < 21)
    {
        if ((_dealerHand.getPipValue > _playerHand.getPipValue) && (_dealerHand.getPipValue > _AIplayerHand.getPipValue)){
        
            dealer_wflag=1;
            player_wflag=0;
            AIplayer_wflag=0;
        
        
            [self gameEnds:Dealer];
        }
        
       else if((_playerHand.getPipValue > _AIplayerHand.getPipValue) && (_playerHand.getPipValue > _dealerHand.getPipValue) &&  (_playerHand.getPipValue <21))
        {
            dealer_wflag=0;
            player_wflag=1;
            AIplayer_wflag=0;
            [self gameEnds:Player];
            
        }
        
        else
        {
            dealer_wflag=0;
            player_wflag=0;
            AIplayer_wflag=1;
            [self gameEnds:AIPlayer];
            
        }
        
    }
    else
        [self gameEnds:Draw ];
    
    
     [self setAIEngine];
}

+(BlackjackModel *) getBlackjackModel{
    if (blackjackModel == nil){
        blackjackModel = [[BlackjackModel alloc] init];
    }
    return blackjackModel;
}

@end
