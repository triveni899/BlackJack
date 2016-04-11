//
//  Deck.m
//  blackjack_tutorial
//

#import "Deck.h"
#import "Card.h"

@implementation Deck


-(id) init {
    if (self = [super init])
    {
        cards = [[NSMutableArray alloc] init];
        
        for (int suit = 0; suit <= 3; suit++)
        {
            for (int cardNumber = 1; cardNumber <= 13; cardNumber++)
            {
                [cards addObject:[[Card alloc] initWithCardNumber:cardNumber suit:suit]];
            }
        }
        
        [self shuffle];
    }
    return self;
}

-(Card *) drawCard {
    if ([cards count]>0)
    {
        Card* tCard = [cards lastObject];
        [cards removeLastObject];
        return tCard;
    }
    return nil;
}

-(void) shuffle {
    NSUInteger count = [cards count];
    for (NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [cards exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

- (NSString *)description{
    return [NSString stringWithFormat:@"Deck : %@", cards];
}

@end
