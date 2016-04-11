//
//  ViewController.h
//  blackjack_tutorial
//
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSMutableArray *allImageViews;

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *HitButton;
@property (weak, nonatomic) IBOutlet UILabel *dealerLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLabel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *standButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *resetButton;

@property NSMutableArray *allImageViews;

- (IBAction)HitCard:(id)sender;
- (IBAction)Stand:(id)sender;
- (IBAction)ResetGame:(id)sender;

@end
