//
//  ViewController.m
//  blackjack_tutorial
//


#import "ViewController.h"
#import "BlackjackModel.h"
#import "Hand.h"
#import "Card.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize dealerLabel=_dealerLabel, playerLabel=_playerLabel, HitButton=_HitButton, standButton=_standButton, resetButton = _resetButton, allImageViews =_allImageViews;


- (void)viewWillAppear:(BOOL)animated{

}

-(void) viewDidDisappear:(BOOL)animated{
    
}

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table2.jpg"]];
        
        _allImageViews = [[NSMutableArray alloc] initWithCapacity:5];
        
        // Do any additional setup after loading the view, typically from a nib.
        [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"dealerHand"
                                                 options:NSKeyValueObservingOptionNew context:NULL];
        [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"playerHand"
                                                 options:NSKeyValueObservingOptionNew context:NULL];
        [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"totalPlays"
                                options:NSKeyValueObservingOptionNew context:NULL];
        
        [[BlackjackModel getBlackjackModel] setup];
        
        
    }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) showHand:(Hand *)hand atXPos:(NSInteger) xPos atYPos:(NSInteger) yPos;
{
    for (int i=0; i< [hand countCards] ; i++) {
        Card *card = [hand getCardAtIndex:i];
    
        UIImage  *cardImage = [ UIImage imageNamed:[card filename]];
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:cardImage];
        CGRect arect = CGRectMake( (i*40)+xPos, yPos, 51, 76);
        imageView.frame = arect;
        
        [_allImageViews addObject:imageView];
        
        [self.view addSubview:imageView];
    }
    
}

-(void) showDealerHand:(Hand *)hand;
{
    [self showHand:hand atXPos:20 atYPos:80];
    _dealerLabel.text = [NSString stringWithFormat:@"Dealer (%d)",[hand getPipValue]];
}

-(void) showPlayerHand:(Hand *)hand;
{
    [self showHand:hand atXPos:60 atYPos:180];
    _playerLabel.text = [NSString stringWithFormat:@"You (%d)",[hand getPipValue]];
    
}


    - (void)observeValueForKeyPath:(NSString *)keyPath
                          ofObject:(id)object
                            change:(NSDictionary *)change
                           context:(void *)context
    {
        
        if ([keyPath isEqualToString:@"dealerHand"])
        {
            [self showDealerHand: (Hand *)[object dealerHand]];
        } else
            if ([keyPath isEqualToString:@"playerHand"])
            {
                [self showPlayerHand: (Hand *)[object playerHand]];
            }
        else if ([keyPath isEqualToString:@"totalPlays"])
        {
            [self endGame];
        }

    }

- (IBAction)HitCard:(id)sender {
    [[BlackjackModel getBlackjackModel] playerHandDraws];
}

- (IBAction)Stand:(id)sender {
    [_HitButton setEnabled:NO];
    [_standButton setEnabled:NO];
    [_resetButton setEnabled:NO];
    
    [[BlackjackModel getBlackjackModel] playerStands];
}

    - (IBAction)ResetGame:(id)sender{
        [_HitButton setEnabled:YES];
        [_standButton setEnabled:YES];
        
        //
        // reset the model
        for (UIView *view in _allImageViews)
        {
            [view removeFromSuperview];
        }
        [_allImageViews removeAllObjects];
        [_dealerLabel setText:@"Dealer"];
        [_playerLabel setText:@"Player"];
        [_resetButton setEnabled:NO];
     
        [[BlackjackModel getBlackjackModel] resetGame];
    }

    -(void) endGame{
        [_HitButton setEnabled:NO];
        [_standButton setEnabled:NO];
        [_resetButton setEnabled:YES];
    }

@end
