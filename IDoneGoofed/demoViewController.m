//
//  demoViewController.m
//  IDoneGoofed
//
//  Created by Marcus Hansen on 17/06/15.
//  Copyright (c) 2015 AbbSommar. All rights reserved.
//

#import "demoViewController.h"

@interface demoViewController ()

@end

@implementation demoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToMain:(id)sender {
    //Send back to main
    
    [self.delegate demoViewControllerDidFinish:self];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
