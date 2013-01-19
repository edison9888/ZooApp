//
//  AGLocationManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGLocationManager.h"
#import "AGAnimalManager.h"
#import "AGRestaurantManager.h"

@implementation AGLocationManager


+ (NSArray*) getAllAnimalMarkers {
    
    NSMutableArray *annotations = [NSMutableArray new];
    [annotations removeAllObjects];
    
    for (AGAnimal *animal in [AGAnimalManager getInstance].allAnimals) {
        
        [annotations addObject:animal.location];
    }
    
    return annotations;
}


+ (NSArray*) getAllRestaurantMarkers {
    
    NSMutableArray *annotations = [NSMutableArray new];
    [annotations removeAllObjects];
    
    for (AGRestaurant *restaurant in [AGRestaurantManager getInstance].allRestaurants) {
        
        [annotations addObject:restaurant.location];
    }
    
    return annotations;
}

@end
