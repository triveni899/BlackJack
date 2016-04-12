//
//  Deck.h
//  blackjack_tutorial
//

#import <Foundation/Foundation.h>

@class Card;

@interface Deck : NSObject {
  NSMutableArray *cards;
}

-(Card *) drawCard;
-(void) shuffle;


@end
