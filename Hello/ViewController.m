//
//  ViewController.m
//  Hello
//
//  Created by Triveni Banpela on 2/3/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

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
