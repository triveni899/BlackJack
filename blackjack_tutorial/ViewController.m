//
//  ViewController.m
//  blackjack_tutorial
//


#import "ViewController.h"
#import "BlackjackModel.h"
#import "Hand.h"
#import "Card.h"
#import "CommonVar.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize dealerLabel=_dealerLabel, playerLabel=_playerLabel,AIplayerLabel=_AIplayerLabel, HitButton=_HitButton,
standButton=_standButton,resetButton = _resetButton, allImageViews =_allImageViews;
 
@synthesize bustedPlayer=_bustedPlayer, bustedAI=_bustedAI, bustedDlr =_bustedDlr,AIMoveButton =_AIMoveButton;


- (void)viewWillAppear:(BOOL)animated{

}

-(void) viewDidDisappear:(BOOL)animated{
    
}

    - (void)viewDidLoad
    {
        [super viewDidLoad];
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"table2.jpg"]];
        //_HitButton.hidden="NO";
        //_standButton.hidden="NO";
       // _AIMoveButton.hidden="YES";
        /*player_bflag=0;AIplayer_bflag=0;dealer_bflag =0;
        player_wflag=0;AIplayer_wflag=0;dealer_wflag =0;
        AIplayerhand=0;playerhand=0;dealerhand =0;
        AIplayerstand=0;playerstand=0;dealerstand =0;
        count=0;*/

        
        _allImageViews = [[NSMutableArray alloc] initWithCapacity:5];
        _bustedPlayer = [[NSMutableArray alloc] init];
        
        // Do any additional setup after loading the view, typically from a nib.
        [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"dealerHand"
                                                 options:NSKeyValueObservingOptionNew context:NULL];
        [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"playerHand"
                                                 options:NSKeyValueObservingOptionNew context:NULL];
        [[BlackjackModel getBlackjackModel]  addObserver:self forKeyPath:@"AIplayerHand"
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

-(void) showAIPlayerHand:(Hand *)hand;
{
    [self showHand:hand atXPos:300 atYPos:180];
    _AIplayerLabel.text = [NSString stringWithFormat:@"AI (%d)",[hand getPipValue]];
    
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
            
        
          if (([keyPath isEqualToString:@"playerHand"]) || ([keyPath isEqualToString:@"AIplayerHand"]) )
            {
               if([keyPath isEqualToString:@"playerHand"]){
                  [self showPlayerHand: (Hand *)[object playerHand]];}
                if(([keyPath isEqualToString:@"AIplayerHand"])){
                    [self showAIPlayerHand: (Hand *)[object AIplayerHand]];}
                
            }
        
        
        
        else if ([keyPath isEqualToString:@"totalPlays"])
        {
            [self endGame];
        }

    }

- (IBAction)AIMoveCard:(id)sender {
    [[BlackjackModel getBlackjackModel] AIplayerHandDraws];
    [self winlosecheck];
}

- (IBAction)HitCard:(id)sender {
    [[BlackjackModel getBlackjackModel] playerHandDraws];
    
    [self winlosecheck];
    [self AIEngineCode];
}


-(void) winlosecheck{
    if(player_bflag == 1)
    {
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"busted5.jpeg"]];
        CGRect arect = CGRectMake(100, 180, 51, 76);
        imageView.frame = arect;
        
        [_bustedPlayer addObject:imageView];
        
        [self.view addSubview:imageView];
    }
    if(dealer_bflag == 1)
    {
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"busted5.jpeg"]];
        CGRect arect = CGRectMake(60, 80, 51, 76);
        imageView.frame = arect;
        
        [_bustedDlr addObject:imageView];
        
        [self.view addSubview:imageView];
        
        
        if(playerhand > AIplayerhand)
        {
            player_wflag=1;
            UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"Winner1.jpeg"]];
            CGRect arect = CGRectMake(100, 180, 51, 76);
            imageView.frame = arect;
            
            [_bustedPlayer addObject:imageView];
            
            [self.view addSubview:imageView];
        }else
        {
            UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"Winner1.jpeg"]];
            CGRect arect = CGRectMake(340, 80, 51, 76);
            imageView.frame = arect;
            
            [_bustedAI addObject:imageView];
            [self.view addSubview:imageView];
            
        }
        
        
    }
    if(AIplayer_bflag == 1)
    {
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"busted5.jpeg"]];
        CGRect arect = CGRectMake(340, 80, 51, 76);
        imageView.frame = arect;
        
        
        [_bustedAI addObject:imageView];
        [self.view addSubview:imageView];
        
        if(playerhand > AIplayerhand)
        {
            player_wflag=1;
            UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"Winner1.jpeg"]];
            CGRect arect = CGRectMake(100, 180, 51, 76);
            imageView.frame = arect;
            
            [_bustedPlayer addObject:imageView];
            
            [self.view addSubview:imageView];
        } else
        {
            UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"loser3.gif"]];
            CGRect arect = CGRectMake(100, 180, 51, 76);
            imageView.frame = arect;
            
            [_bustedPlayer addObject:imageView];
            
            [self.view addSubview:imageView];
        }
    }
    
    if((AIplayer_wflag == 1)||(dealer_wflag == 1))
    {
        
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"loser3.gif"]];
        CGRect arect = CGRectMake(100, 180, 51, 76);
        imageView.frame = arect;
        
        [_bustedPlayer addObject:imageView];
        
        [self.view addSubview:imageView];
    } else if (player_wflag == 1)
    {
        
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[ UIImage imageNamed:@"Winner1.jpg"]];
        CGRect arect = CGRectMake(100, 180, 51, 76);
        imageView.frame = arect;
        
        [_bustedPlayer addObject:imageView];
        
        [self.view addSubview:imageView];
    }
    

}  //win lose check


-(void)AIEngineCode{
    if(AIplayerstand == 1)
    {
        _AIplayerLabel.text = [NSString stringWithFormat:@"AI Stands (%d)",AIplayerhand];
    }else
    if((playerstand == 1) && (AIplayerstand == 0))
    {
            [_AIMoveButton setHidden:NO];
            [_HitButton setHidden:YES];
             [_standButton setHidden:YES];
    }
    else{
        
     [[BlackjackModel getBlackjackModel] AIplayerHandDraws];
    }
    
}

- (IBAction)Stand:(id)sender {
    [_HitButton setEnabled:NO];
    [_standButton setEnabled:NO];
    [_resetButton setEnabled:NO];
    
    [[BlackjackModel getBlackjackModel] playerStands];
    
    [self winlosecheck];
    
}

    - (IBAction)ResetGame:(id)sender{
        [_HitButton setEnabled:YES];
        [_standButton setEnabled:YES];
        [_AIMoveButton setHidden:YES];
        //[_AIHitButton setEnabled:YES];
        //[_AIStandButton setEnabled:YES];
        
        //
        // reset the model
        for (UIView *view in _allImageViews)
        {
            [view removeFromSuperview];
        }
        
        [_allImageViews removeAllObjects];
       
    
        [_dealerLabel setText:@"Dealer"];
        [_playerLabel setText:@"You"];
        [_AIplayerLabel setText:@"AI Player"];
        [_resetButton setEnabled:NO];
        
        [[BlackjackModel getBlackjackModel] resetGame];
        
    }

- (void)AIHitCard {
     [[BlackjackModel getBlackjackModel] AIplayerHandDraws];
}
//this will go in AI code
- (void)AIStand{
    //[_AIHitButton setEnabled:NO];
    //[_AIStandButton setEnabled:NO];
    [_resetButton setEnabled:NO];
    
    [[BlackjackModel getBlackjackModel] AIplayerStands];
}

    -(void) endGame{
        [_HitButton setEnabled:NO];
        [_standButton setEnabled:NO];
        //[_AIHitButton setEnabled:NO];
        //[_AIStandButton setEnabled:NO];
        [_resetButton setEnabled:YES];
    }

@end
