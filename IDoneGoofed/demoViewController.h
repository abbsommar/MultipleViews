//
//  demoViewController.h
//  IDoneGoofed
//
//  Created by Marcus Hansen on 17/06/15.
//  Copyright (c) 2015 AbbSommar. All rights reserved.
//

#import <UIKit/UIKit.h>

@class demoViewController;

@protocol demoViewControllerDelegate <NSObject>
-(void)demoViewControllerDidFinish:(demoViewController *)demoVC;

@end

@interface demoViewController : UIViewController



@property (weak, nonatomic) id<demoViewControllerDelegate> delegate;

@end
