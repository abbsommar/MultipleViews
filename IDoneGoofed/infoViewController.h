//
//  infoViewController.h
//  IDoneGoofed
//
//  Created by Marcus Hansen on 12/06/15.
//  Copyright (c) 2015 AbbSommar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class infoViewController;

@protocol infoViewControllerDelegate <NSObject>

-(void)infoViewContreollerDidFinish:(infoViewController *)infoVC;

@end


@interface infoViewController : UIViewController

@property (weak, nonatomic) id<infoViewControllerDelegate> delegate;

@end