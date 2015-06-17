//
//  ViewController.m
//  IDoneGoofed
//
//  Created by Marcus Hansen on 12/06/15.
//  Copyright (c) 2015 AbbSommar. All rights reserved.
//

#import "ViewController.h"
#import "infoViewController.h"
#import </Users/Maccan/Documents/Developer/IDoneGoofed/EstimoteSDK.framework/Headers/ESTBeaconManager.h>




@interface ViewController () <infoViewControllerDelegate>
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@end

@implementation ViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
}
- (IBAction)showInfoView:(id)sender {
    infoViewController *infoVC = [[infoViewController alloc]init];
    
    infoVC.delegate = self;
    
    [self presentViewController:infoVC animated:YES completion:nil];
    
    
}

-(void) infoViewContreollerDidFinish:(infoViewController *)infoVC{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
