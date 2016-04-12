//
//  BlackjackModel.h
//  blackjack_tutorial
//
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Hand.h"
#import "CommonVar.h"

typedef enum {
    Player,
    AIPlayer,
    Dealer,
    Draw
} Winner;

@interface BlackjackModel : NSObject
{
    Hand *dealerHand;
    Hand *playerHand;
    Hand *AIplayerHand;
    Deck *deck;
    int totalPlays;
    int flag_player;
}

@property Hand *dealerHand;
@property Hand *playerHand;
@property Hand *AIplayerHand;
@property Deck *deck;
@property int totalPlays;
@property int flag_player;
@property (nonatomic, strong) UIImageView *Busted;

-(void) setup;
-(void) resetGame;
-(void) playerHandDraws;
-(void) playerStands;
-(void) AIplayerHandDraws;
-(void) AIplayerStands;

+(BlackjackModel *)getBlackjackModel;




@end
