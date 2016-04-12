    //
    //  Card.m
    //  blackjack_tutorial
    //

    #import "Card.h"


    @implementation Card

@synthesize suit = _suit, cardNumber=_cardNumber, cardClosed=_cardClosed;


    -(id) initWithCardNumber:(NSInteger)aCardNumber suit:(Suit)aSuit {
        if (self = [super init])
        {
            _suit = aSuit;
            _cardNumber = aCardNumber;
            _cardClosed = NO;
        }
        return self;
    }

    /*
     ** pipValue will return the pipValue of a card.
     **          2 to 10 will return 2 to 10.
     **          an ace will always return 1
     **          Jack, Queen and King will always return 10.
     **
     ** TODO: Ace should be able to return either 11 or 1
     */
    -(NSInteger) pipValue {
        if (_cardClosed==YES)
        {
            return (0);
        }
        else if (_cardNumber>=10)
            return (10);
        else if (_cardNumber==1)
            return (11);
        else
            return (_cardNumber);
    }

    /*
     ** private method
     ** returns the suit as a String
     */
    -(NSString *) suitAsString{
        switch (_suit) {
            case Hearts:
                return @"Heart";
                break;
            case Spades:
                return @"Spade";
                break;
            case Diamonds:
                return @"Diamond";
                break;
            case Clubs:
                return @"Club";
                break;
            default:
                return nil;
                break;
        }
    }

    /*
     ** private method
     ** returns the cardNumber as a String
     */
    -(NSString *) cardNumberAsString{
        switch (_cardNumber) {
            case 1:
                return @"Ace";
                break;
            case 11:
                return @"Jack";
                break;
            case 12:
                return @"Queen";
                break;
            case 13:
                return @"King";
                break;
            default:
                return [NSString stringWithFormat:@"%d", _cardNumber];
                break;
        }
    }

    -(NSString *) filename{
        if (_cardClosed==YES)
            return @"closed2.png";
        else
            return [NSString stringWithFormat:@"%@%02d.gif", [self suitAsString], [self cardNumber]];
    }

    -(NSString *) description {
        return [NSString stringWithFormat:@"%@ %@ (pipValue = %d)", [self suitAsString], [self cardNumberAsString], [self pipValue]];
    }

    @end
