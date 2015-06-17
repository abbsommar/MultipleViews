//
//  infoViewController.m
//  IDoneGoofed
//
//  Created by Marcus Hansen on 12/06/15.
//  Copyright (c) 2015 AbbSommar. All rights reserved.
//

#import "infoViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import </Users/Maccan/Documents/Developer/IDoneGoofed/EstimoteSDK.framework/Headers/ESTBeaconManager.h>



@interface infoViewController () <ESTBeaconManagerDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong) CLBeacon *beacon;
@property (nonatomic, strong) ESTBeaconManager *beaconManager;
@property (nonatomic, strong) CLBeaconRegion *beaconRegionYes;
@property (nonatomic, strong) CLBeaconRegion *beaconRegionNo;
@property (nonatomic, strong) CLBeaconRegion *region;
@end

@implementation infoViewController  

@synthesize statusLbl, signalStrengthLbl, beaconLbl;

- (IBAction)doneButtonPressed:(id)sender {
    //Sends you back to startscreen
    [self.delegate infoViewContreollerDidFinish:self];
    
   
    
    
}
//
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _locationManager = [[CLLocationManager alloc]init];
    _locationManager.delegate = self;
    self.beaconLabel.text = @"";
    //Create your UUID
    NSUUID *uuidYes = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    NSUUID *uuidNo = [[NSUUID alloc] initWithUUIDString:@"B9407F30-F5F8-466E-AFF9-25556B57FE6D"];
    
    
    //set up the beacon manager
    self.beaconManager = [[ESTBeaconManager alloc] init];
    self.beaconManager.delegate = self;
    
    //set up the beacon region
    self.region = [[CLBeaconRegion alloc] initWithProximityUUID:uuidNo identifier:@"Estimotes"];
    
    //Blueberry Pie
    self.beaconRegionYes = [[CLBeaconRegion alloc] initWithProximityUUID:uuidYes
                                                                   major:16365
                                                                   minor:45820
                                                              identifier:@"regionYes"];
    //icy Marshmallow
    self.beaconRegionNo = [[CLBeaconRegion alloc] initWithProximityUUID:uuidNo
                                                                  major:26500
                                                                  minor:21156
                                                             identifier:@"regionNo"];
    
    //let us know when we exit and enter a region
    self.beaconRegionYes.notifyOnEntry = YES;
    self.beaconRegionYes.notifyOnExit = YES;
    self.beaconRegionNo.notifyOnEntry = YES;
    self.beaconRegionNo.notifyOnExit = YES;
    
    
    //start  monitorinf
    [self.beaconManager startMonitoringForRegion:self.beaconRegionYes];
    [self.beaconManager startMonitoringForRegion:self.beaconRegionNo];
    
    
    
    //start the ranging
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegionYes];
    [self.beaconManager startRangingBeaconsInRegion:self.beaconRegionNo];
    
    //MUST have for IOS8
    [self.beaconManager requestAlwaysAuthorization];
}

//check for region failure
-(void)beaconManager:(ESTBeaconManager *)manager monitoringDidFailForRegion:(CLBeaconRegion *)region withError:(NSError *)error
{
    NSLog(@"Region Did Fail: Manager:%@ Region:%@ Error:%@",manager, region, error);
}

//checks permission status
-(void)beaconManager:(ESTBeaconManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Status:%d", status);
}

//Beacon manager did enter region
- (void)beaconManager:(ESTBeaconManager *)manager didEnterRegion:(CLBeaconRegion *)region
{
    //Adding a custom local notification to be presented
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = @"Youve done it!";
    notification.soundName = @"Default.mp3";
    NSLog(@"Youve entered");
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
    
}

//Beacon Manager did exit the region
- (void)beaconManager:(ESTBeaconManager *)manager didExitRegion:(CLBeaconRegion *)region
{
    //adding a custon local notification
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    notification.alertBody = @"Youve exited!!!";
    NSLog(@"Youve exited");
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}


-(void)beaconManager:(ESTBeaconManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
    if (beacons.count > 0) {
        CLBeacon *firstBeacon = [beacons firstObject];
        self.beaconLabel.text = [self textForProximity:firstBeacon.proximity];
        self.statusLbl.text = [NSString stringWithFormat:@"Status: %@", [self textForProximity:firstBeacon.proximity]];
        self.signalStrengthLbl.text = [NSString stringWithFormat:@"Signal Strength: %@", [self textForsignalStrength:beacons.firstObject]];
        
        if([region.identifier isEqualToString:@"regionYes"] &&  [[self textForProximity:firstBeacon.proximity] isEqualToString:@"Immediate"] && firstBeacon.accuracy < 1.0f)
        {
            NSLog(@"Yes!");
            beaconLbl.text = [NSString stringWithFormat:@"Yes!"];
            beaconLbl.textColor = [UIColor greenColor];
        }
        else if([region.identifier isEqualToString:@"regionNo"] && [[self textForProximity:firstBeacon.proximity] isEqualToString:@"Immediate"] && firstBeacon.accuracy < 1.0f)
        {
            NSLog(@"No!");
            beaconLbl.text = [NSString stringWithFormat:@"No!"];
            beaconLbl.textColor = [UIColor redColor];
        }
        else
            beaconLbl.text = [NSString stringWithFormat:@"None!"];
        
    }
    else
    {
        self.statusLbl.text = [NSString stringWithFormat:@"Hittar inte alla beacons."];
        self.signalStrengthLbl.text = [NSString stringWithFormat:@"Hittar inte alla beacons."];
    }
    
}

-(NSString *)textForProximity:(CLProximity)proximity
{
    
    switch (proximity) {
        case CLProximityFar:
            self.signalStrengthLbl.textColor = [UIColor blueColor];
            return @"Far";
            break;
        case CLProximityNear:
            self.signalStrengthLbl.textColor = [UIColor purpleColor];
            return @"Near";
            break;
        case CLProximityImmediate:
            self.signalStrengthLbl.textColor = [UIColor redColor];
            return @"Immediate";
            break;
        case CLProximityUnknown:
            return @"Unknown";
            break;
        default:
            break;
    }
}

-(NSString *) textForsignalStrength:(CLBeacon*)beacon
{
    if(beacon.accuracy < 1.5f)
    {
        return @"Good!";
    }
    else if(beacon.accuracy > 1.5f && beacon.accuracy < 2.5f)
    {
        return @"Medium!";
    }
    else if (beacon.accuracy > 3.5f)
        return @"Bad!";
    else
        return @"None";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
