//
//  ViewController.m
//  Project2048
//
//  Created by Triveni Banpela on 2/4/16.
//  Copyright © 2016 Triveni Banpela. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

 NSInteger result=0;
int scoreU=0,scoreD=0,scorel=0;
int scoreR=0;
int sum;
@implementation ViewController

@synthesize rowlabel;
@synthesize scoreLabel;
@synthesize StatusLabel;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
  
    for(NSInteger i=0; i<rowlabel.count; i++) {
        
        [[rowlabel objectAtIndex:i] setText:@" "];
        
        
    }
    
    [[rowlabel objectAtIndex:0] setText:@"2"];
    [[rowlabel objectAtIndex:4] setText:@"2"];
    [scoreLabel setText:@"0"];
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)UpButton:(id)sender {
   
   int match_counter = 0;
    
    for(int i=15; i>=0; i--)
    {
        match_counter = 0;
            if(!([[[rowlabel objectAtIndex:i] text]isEqual:(@" ")]))
            {
                if(((i-4)>=0)&&!([[[rowlabel objectAtIndex:i-4] text]isEqual:(@" ")]))
                {
                    if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i-4] text]intValue])
                    {
                        [self match:i andNum2:i-4];
                    }//value matches
                    
                    else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                        match_counter = 1;
                    }
                    
                }// (i-4) is not spaces ends
                
                
                
                else //check for (i-8)
                if(((i-8)>=0)&& (!([[[rowlabel objectAtIndex:i-8] text]isEqual:(@" ")])) && (match_counter == 0))
                {
                        if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i-8] text]intValue])
                        {
                                [self match:i andNum2:i-8];
                        }//value matches
                                
                        else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                            if((i-4)>=0)
                            {
                            NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                            [[rowlabel objectAtIndex:i-4] setText:[NSString stringWithFormat:@"%d",value]];
                            [[rowlabel objectAtIndex:i] setText:@" "];
                            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                            [self matchColor:value andIndex:i-4];
                        
                            
                            }
                            
                            match_counter = 1;
                        }
                            
                }//chk for (i-8) >0 ends
                
                
                
                else  // check for(i-12)
                if(((i-12)>=0)&& (!([[[rowlabel objectAtIndex:i-12] text]isEqual:(@" ")])) && (match_counter == 0))
                {
                        if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i-12] text]intValue])
                        {
                            [self match:i andNum2:i-12];
                        }//value matches
                        
                        else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                            if((i-8)>=0)
                            {
                            NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                            [[rowlabel objectAtIndex:i-8] setText:[NSString stringWithFormat:@"%d",value]];
                            [[rowlabel objectAtIndex:i] setText:@" "];
                            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                            [self matchColor:value andIndex:i-8];
                            //[[rowlabel objectAtIndex:i-8] setBackgroundColor: [UIColor lightGrayColor]];
                            }

                            match_counter = 1;
                        }
                        
                }//chk for (i-12) >0 ends
                
                
                else  // send everything up
                {
                    if(match_counter == 0)
                    {
                        if((i-12)>=0)
                        {
                        NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                       [[rowlabel objectAtIndex:i-12] setText:[NSString stringWithFormat:@"%d",value]];
                        [[rowlabel objectAtIndex:i] setText:@" "];
                        [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                        [self matchColor:value andIndex:i-12];
                        //[[rowlabel objectAtIndex:i-12] setBackgroundColor: [UIColor lightGrayColor]];
                        }
                        
                    }//chk for (i-12) >0 ends
                }//else everything check loop ends
                
                
                
              
            }//when value i is not spaces ends
            
    
    }//for loop ends
    
    
        [self randomNumber];
   
    
         [self setScore];
    scoreU = sum;
    
    [self makeSound];
    
    [self chkGameOver];
    
    
}//Upbutton ends


/********** Down  Button Starts ********************/

- (IBAction)DownButton:(id)sender {
    
    
    int match_counter = 0;
    
    for(int i=0; i<=15; i++)
    {
        match_counter = 0;
        if(!([[[rowlabel objectAtIndex:i] text]isEqual:(@" ")]))
        {
            if(((i+4)<=15)&&!([[[rowlabel objectAtIndex:i+4] text]isEqual:(@" ")]))
            {
                if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i+4] text]intValue])
                {
                    [self match:i andNum2:i+4];
                }//value matches
                
                else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                    match_counter = 1;
                }
                
            }// (i+4) is not spaces ends
            
            
            
            else //check for (i+8)
                if(((i+8)<=15)&& (!([[[rowlabel objectAtIndex:i+8] text]isEqual:(@" ")])) && (match_counter == 0))
                {
                    if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i+8] text]intValue])
                    {
                        [self match:i andNum2:i+8];
                    }//value matches
                    
                    else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                        if((i+4)<=15)
                        {
                            NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                            [[rowlabel objectAtIndex:i+4] setText:[NSString stringWithFormat:@"%d",value]];
                            [[rowlabel objectAtIndex:i] setText:@" "];
                            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                            [self matchColor:value andIndex:i+4];
                           // [[rowlabel objectAtIndex:i+4] setBackgroundColor: [UIColor lightGrayColor]];
                            
                        }
                        
                        match_counter = 1;
                    }
                    
                }//chk for (i+8) >0 ends
            
            
            
                else  // check for(i+12)
                    if(((i+12)<=15)&& (!([[[rowlabel objectAtIndex:i+12] text]isEqual:(@" ")])) && (match_counter == 0))
                    {
                        if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i+12] text]intValue])
                        {
                            [self match:i andNum2:i+12];
                        }//value matches
                        
                        else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                            if((i+8)<=15)
                            {
                                NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                [[rowlabel objectAtIndex:i+8] setText:[NSString stringWithFormat:@"%d",value]];
                                [[rowlabel objectAtIndex:i] setText:@" "];
                                 [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                                [self matchColor:value andIndex:i+8];
                               // [[rowlabel objectAtIndex:i+8] setBackgroundColor: [UIColor lightGrayColor]];
                            }
                            
                            match_counter = 1;
                        }//else chk ends
                        
                    }//chk for (i+12) >0 ends
            
            
                    else  // send everything down
                    {
                        if(match_counter == 0)
                        {
                            if((i+12)<=15)
                            {
                                NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                [[rowlabel objectAtIndex:i+12] setText:[NSString stringWithFormat:@"%d",value]];
                                [[rowlabel objectAtIndex:i] setText:@" "];
                                 [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                                [self matchColor:value andIndex:i+12];
                               // [[rowlabel objectAtIndex:i+12] setBackgroundColor: [UIColor lightGrayColor]];
                            }
                            
                        }//chk for match counter
                    }//else everything check loop ends
            
            
            
            
        }//when value i is not spaces ends
        
        
    }//for loop ends
    
    
    [self randomNumber];
    
     [self setScore];
    scoreD = sum;
     [self makeSound];
    
    
    [self chkGameOver];
    
    
} //DownButton ends

//*************************** Right Button Starts ******************************//

- (IBAction)RightButton:(id)sender {
    
    
    int match_counter = 0;
    
    for(int i=0; i<=15; i++)
    {
        match_counter = 0;
        if(!([[[rowlabel objectAtIndex:i] text]isEqual:(@" ")]))
        {
        if((i!=3) && (i!=7) && (i!=11) && (i!=15))
        {
            
            if(((i+1)<=15)&&!([[[rowlabel objectAtIndex:(i+1)] text]isEqual:(@" ")]) )
            {
                if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i+1] text]intValue])
                {
                    [self match:i andNum2:i+1];
                }//value matches
                
                else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                    match_counter = 1;
                }
                
            }// (i+1) is not spaces ends
            
            
            
            else //check for (i+2)
                if(((i+2)<=15)&& (!([[[rowlabel objectAtIndex:i+2] text]isEqual:(@" ")])) && (match_counter == 0))
                {
                    if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i+2] text]intValue])
                    {
                        [self match:i andNum2:i+2];
                    }//value matches
                    
                    else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                        if((i+1)<=15)
                        {
                            NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                            [[rowlabel objectAtIndex:i+1] setText:[NSString stringWithFormat:@"%d",value]];
                            [[rowlabel objectAtIndex:i] setText:@" "];
                            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                            [self matchColor:value andIndex:i+1];
                            //[[rowlabel objectAtIndex:i+1] setBackgroundColor: [UIColor lightGrayColor]];
                            
                        }
                        
                        match_counter = 1;
                    }
                    
                }//chk for (i+2) >0 ends
            
            
            
                else  // check for(i+3)
                    if(((i+3)<=15)&& (!([[[rowlabel objectAtIndex:i+3] text]isEqual:(@" ")])) && (match_counter == 0))
                    {
                        if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i+3] text]intValue])
                        {
                            [self match:i andNum2:i+3];
                        }//value matches
                        
                        else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                            if((i+2)<=15)
                            {
                                NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                [[rowlabel objectAtIndex:i+2] setText:[NSString stringWithFormat:@"%d",value]];
                                [[rowlabel objectAtIndex:i] setText:@" "];
                                [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                                [self matchColor:value andIndex:i+2];
                               // [[rowlabel objectAtIndex:i+2] setBackgroundColor: [UIColor lightGrayColor]];
                            }
                            
                            match_counter = 1;
                        }//else chk ends
                        
                    }//chk for (i+3) >0 ends
            
            
                    else  // send everything down
                    {
                        if(match_counter == 0)
                        {
                            if((i+3)<=15)
                            {
                                NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                [[rowlabel objectAtIndex:(i+3)] setText:[NSString stringWithFormat:@"%d",value]];
                                
                                [[rowlabel objectAtIndex:i] setText:@" "];
                                [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                               // [[rowlabel objectAtIndex:(i+3)] setBackgroundColor: [UIColor lightGrayColor]];
                               [self matchColor:value andIndex:i+3];
                            }
                            
                        }//chk for match counter
                    }//else everything check loop ends
            
            
            
        }//if i is not 3 or 7 or 11 or 15 ends
            
        }//when value i is not spaces ends
        
        
    }//for loop ends
    
   
    
    [self randomNumber];
    
     [self setScore];
    scoreR = sum;
     [self makeSound];
    
    [self chkGameOver];
    
} //RightButton ends


//**************************** Left Button Starts ********************************//

- (IBAction)LeftButton:(id)sender {
 
    int match_counter = 0;
    
    for(int i=15; i>=0; i--)
    {
        match_counter = 0;
        if(!([[[rowlabel objectAtIndex:i] text]isEqual:(@" ")]))
        {
            if((i!=0) && (i!=4) && (i!=8) && (i!=12))
            {
                
                if(((i-1)>=0)&&!([[[rowlabel objectAtIndex:(i-1)] text]isEqual:(@" ")]) )
                {
                    if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i-1] text]intValue])
                    {
                        [self match:i andNum2:i-1];
                    }//value matches
                    
                    else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                        match_counter = 1;
                    }
                    
                }// (i+1) is not spaces ends
                
                
                
                else //check for (i-2)
                    if(((i-2)>=0)&& (!([[[rowlabel objectAtIndex:i-2] text]isEqual:(@" ")])) && (match_counter == 0))
                    {
                        if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i-2] text]intValue])
                        {
                            [self match:i andNum2:i-2];
                        }//value matches
                        
                        else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                            if((i-1)>=0)
                            {
                                NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                [[rowlabel objectAtIndex:i-1] setText:[NSString stringWithFormat:@"%d",value]];
                                [[rowlabel objectAtIndex:i] setText:@" "];
                                [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                               // [[rowlabel objectAtIndex:i-1] setBackgroundColor: [UIColor lightGrayColor]];
                                [self matchColor:value andIndex:i-1];
                                
                            }
                            
                            match_counter = 1;
                        }
                        
                    }//chk for (i-2) >0 ends
                
                
                
                    else  // check for(i-3)
                        if(((i-3)>=0)&& (!([[[rowlabel objectAtIndex:i-3] text]isEqual:(@" ")])) && (match_counter == 0))
                        {
                            if([[[rowlabel objectAtIndex:i] text]intValue]==[[[rowlabel objectAtIndex:i-3] text]intValue])
                            {
                                [self match:i andNum2:i-3];
                            }//value matches
                            
                            else{  //else value is not equal but kuch aur hai tab sab wahin rok do
                                if((i-2)>=0)
                                {
                                    NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                    [[rowlabel objectAtIndex:i-2] setText:[NSString stringWithFormat:@"%d",value]];
                                    [[rowlabel objectAtIndex:i] setText:@" "];
                                    [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                                   // [[rowlabel objectAtIndex:i-2] setBackgroundColor: [UIColor lightGrayColor]];
                                    [self matchColor:value andIndex:i-2];
                                }
                                
                                match_counter = 1;
                            }//else chk ends
                            
                        }//chk for (i+3) >0 ends
                
                
                        else  // send everything down
                        {
                            if(match_counter == 0)
                            {
                                if((i-3)>=0)
                                {
                                    NSInteger value = [[[rowlabel objectAtIndex:i] text]intValue];
                                    [[rowlabel objectAtIndex:(i-3)] setText:[NSString stringWithFormat:@"%d",value]];
                                    
                                    [[rowlabel objectAtIndex:i] setText:@" "];
                                    [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
                                  //  [[rowlabel objectAtIndex:(i-3)] setBackgroundColor: [UIColor lightGrayColor]];
                                    
                                    [self matchColor:value andIndex:i-3];
                                    /*  NSLog(@"value of i is %ld", (long)(i));
                                     NSLog(@"value of i plus 3 is %ld", (long)(i+3));
                                     NSLog(@"value of label text in i plus 3 is %@", [[rowlabel objectAtIndex:(i+3)] text]);
                                     */
                                }
                                
                            }//chk for match counter
                        }//else everything check loop ends
                
                
                
            }//if i is not 3 or 7 or 11 or 15 ends
            
        }//when value i is not spaces ends
        
        
    }//for loop ends
   
    
    [self randomNumber];
    
    [self setScore];
    scorel = sum;
     [self makeSound];
    
    
    [self chkGameOver];
    
    
    
}  //Left Button ends



- (void)randomNumber {
    NSInteger j=15;
    while(j>=0)
    {
        if([[[rowlabel objectAtIndex:j] text]isEqual:(@" ")]){
        [[rowlabel objectAtIndex:j] setText:@"2"];
        [[rowlabel objectAtIndex:j] setBackgroundColor: [UIColor lightTextColor]];
        break;
        } else { j--; }
    }
    
}

- (void)match:(int)i1 andNum2:(int) i2{
    
    
    
        result = [[[rowlabel objectAtIndex:i1] text]intValue] + [[[rowlabel objectAtIndex:i2] text]intValue];
        [[rowlabel objectAtIndex:i2] setText:[NSString stringWithFormat:@"%d",result]];
        [[rowlabel objectAtIndex:i1] setText:@" "];
        [self matchColor:result andIndex:i2];
        [[rowlabel objectAtIndex:i1] setBackgroundColor: [UIColor lightGrayColor]];
    
    
}

- (void)matchColor:(int)labelval andIndex:(int) i
{
    switch(labelval)
    {
        case 2:
             [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
            break;
        case 4:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor blueColor]];
            break;
        case 8:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor redColor]];
            break;
        case 16:
             [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor greenColor]];
            break;
        case 32:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor whiteColor]];
            break;
        case 64:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor yellowColor]];
            break;
        case 128:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor purpleColor]];
            break;
        case 256:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor brownColor]];
            break;
        case 512:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor orangeColor]];
            break;
        case 1024:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor darkGrayColor]];
            break;
        case 2048:
            [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor magentaColor]];
            break;
        default:
             [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
            break;
            
            
            
            
    }
    
}

- (void)setScore{
   int sum1=0,value =0;
    
    for(int i=0; i<=15; i++) {
        
     if(!([[[rowlabel objectAtIndex:i] text]isEqual:(@" ")]))
     {
         value = [[[rowlabel objectAtIndex:i] text]intValue];
        sum1=sum1+value;
    
     }
        
    }
    sum = sum1;
    [scoreLabel setText:[NSString stringWithFormat:@"%d",sum1]];
   

    
}


- (IBAction)StartButton:(id)sender {
    
    
    for(NSInteger i=0; i<=15; i++) {
        
        [[rowlabel objectAtIndex:i] setText:@" "];
        [[rowlabel objectAtIndex:i] setBackgroundColor: [UIColor lightGrayColor]];
        
        
    }
    
     [[rowlabel objectAtIndex:0] setText:@"2"];
     [[rowlabel objectAtIndex:12] setText:@"2"];
    [scoreLabel setText:@"0"];
      [StatusLabel setEnabled:(false)];
    [StatusLabel setHidden:(true)];
     [self makeSound];
    
    
}

-(void)makeSound{
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle]
                                         pathForResource:@"tick"
                                         ofType:@"wav"]];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    // player.numberOfLoops = 1;
    [player play];
}

-(void)chkGameOver{
    
 if(((sum == scoreU) && (sum == scorel) && (sum==scoreR) && (sum==scoreD)))
 {
           [StatusLabel setEnabled:(true)];
            [StatusLabel setHidden:(false)];
           [StatusLabel setText:@"GAME OVER !! PRESS START"];
           [StatusLabel setBackgroundColor: [UIColor redColor]];

 }
}


@end
