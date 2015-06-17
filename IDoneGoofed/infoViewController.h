//
//  infoViewController.h
//  IDoneGoofed
//
//  Created by Marcus Hansen on 12/06/15.
//  Copyright (c) 2015 AbbSommar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@class infoViewController;

@protocol infoViewControllerDelegate <NSObject>

-(void)infoViewContreollerDidFinish:(infoViewController *)infoVC;

@end


@interface infoViewController : UIViewController<CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *signalStrengthLbl;
@property (weak, nonatomic) IBOutlet UILabel *beaconLbl;
@property (weak, nonatomic) IBOutlet UILabel *beaconLabel;
@property (strong, nonatomic) CLLocationManager *locationManager;



@property (weak, nonatomic) id<infoViewControllerDelegate> delegate;

@end
