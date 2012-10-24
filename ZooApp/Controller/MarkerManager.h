//
//  MarkerManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Animal.h"
#import "Location.h"

@interface MarkerManager : NSObject


+ (NSArray*) createAllAnimalMarkers;
+ (Location*) createMarkerForAnimal: (Animal*) animal;

@end