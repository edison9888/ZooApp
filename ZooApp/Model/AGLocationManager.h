//
//  AGLocationManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGLocation.h"

@interface AGLocationManager : NSObject

+ (NSArray*) getAllAnimalMarkers;
+ (NSArray*) getAllRestaurantMarkers;

@end
