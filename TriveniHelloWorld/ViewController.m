//
//  ViewController.m
//  TriveniHelloWorld
//
//  Created by Navneet  Magotra on 2/2/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

#import "ViewController.h"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"world.png"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonHelloWorld:(id)sender {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"wave.jpg"]];
    _labelHelloWorld.text=[NSString stringWithFormat:@"Triveni Says Hello World"];
}
@end
