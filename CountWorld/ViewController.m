//
//  ViewController.m
//  CountWorld
//
//  Created by Triveni Banpela on 2/3/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

#import "ViewController.h"
NSInteger x=0;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    

     _labelHelloWorld.text=[NSString stringWithFormat:@"Triveni"];
    
  [self performSelector:@selector(secondMethod) withObject:nil afterDelay:2.5 ];
    
    
    
}

- (void)firstMethod{
    
    
    _labelHelloWorld.text=[NSString stringWithFormat:@"Triveni"];
    [self performSelector:@selector(secondMethod) withObject:nil afterDelay:2.5 ];
}


- (void)secondMethod{
    
    
    _labelHelloWorld.text=[NSString stringWithFormat:@"Says"];
     [self performSelector:@selector(thirdMethod) withObject:nil afterDelay:2.5 ];
}

- (void)thirdMethod{
    
    
    _labelHelloWorld.text=[NSString stringWithFormat:@"Hello"];
     [self performSelector:@selector(fourthMethod) withObject:nil afterDelay:2.5 ];
}

- (void)fourthMethod{
    
    
    _labelHelloWorld.text=[NSString stringWithFormat:@"World"];
     [self performSelector:@selector(firstMethod) withObject:nil afterDelay:2.5 ];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ButtonClickMe:(id)sender {
    
     _labelHelloWorld.text=[NSString stringWithFormat:@"Triveni Says Hello World"];
    
    [self performSelector:@selector(firstMethod) withObject:nil afterDelay:2.5 ];
    
    
   
   
}
@end
