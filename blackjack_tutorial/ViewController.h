//
//  ViewController.h
//  blackjack_tutorial
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSMutableArray *allImageViews;
    int flag_player;
}


@property (weak, nonatomic) IBOutlet UILabel *dealerLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UILabel *AIplayerLabel;

@property (weak, nonatomic) IBOutlet UIButton *HitButton;
@property (weak, nonatomic) IBOutlet UIButton *standButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSMutableArray *bustedPlayer;


//@property (weak, nonatomic) IBOutlet UIButton *AIHitButton;
//@property (weak, nonatomic) IBOutlet UIButton *AIStandButton;

@property NSMutableArray *allImageViews;
@property int flag_player;

- (IBAction)HitCard:(id)sender;
- (IBAction)Stand:(id)sender;
- (IBAction)ResetGame:(id)sender;
//- (IBAction)AIHitCard:(id)sender;
//- (IBAction)AIStand:(id)sender;


@end
