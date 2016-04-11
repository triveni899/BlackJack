    //
    //  Hand.h
    //  blackjack_tutorial
    //

    #import <Foundation/Foundation.h>
    @class Card;

    @interface Hand : NSObject {
    }

    @property NSMutableArray *cardsInHand;
    @property BOOL handClosed;

    -(void) addCard:(Card *)card;
    -(NSInteger) getPipValue;
    -(NSInteger) countCards;
    -(Card *) getCardAtIndex:(NSInteger) index;

    @end
