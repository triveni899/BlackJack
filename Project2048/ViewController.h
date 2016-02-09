//
//  ViewController.h
//  Project2048
//
//  Created by Triveni Banpela on 2/4/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//


#import <UIKit/UIKit.h>


@interface ViewController : UIViewController
@property(nonatomic,strong) IBOutletCollection(UILabel) NSArray *rowlabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (weak, nonatomic) IBOutlet UIButton *UpButton;
@property (weak, nonatomic) IBOutlet UIButton *DownButton;
@property (weak, nonatomic) IBOutlet UIButton *LeftButton;
@property (weak, nonatomic) IBOutlet UIButton *RightButton;
@property (weak, nonatomic) IBOutlet UIButton *StartButton;



@end

