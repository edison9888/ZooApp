//
//  AGCompassView.h
//  ZooApp
//
//  Created by Andrea Gerlach on 15.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AGAnimal.h"

@interface AGCompassView : UIView <CLLocationManagerDelegate> {}

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) UIView *compassContainer;
@property (nonatomic, strong) AGAnimal *currentAnimal;
@property (nonatomic, strong) CLLocation *poiLocation;
@property (nonatomic, strong) CLLocation *currentLocation;
@property (nonatomic, assign) CGFloat currentAngle;


@end
