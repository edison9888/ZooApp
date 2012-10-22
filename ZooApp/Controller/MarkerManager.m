//
//  MarkerManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "MarkerManager.h"
#import "Animal.h"
#import "Location.h"


@implementation MarkerManager

+ (NSArray*) createAllAnimalMarkers {
    
    NSMutableArray *annotations = [NSMutableArray new];
    [annotations removeAllObjects];
    
    for (Animal *animal in Animal.getAllAnimals) {
        NSLog(@"hiugdfhg");
        CLLocationCoordinate2D animalCoordinate;
        animalCoordinate.latitude = animal.latitude.doubleValue;
        animalCoordinate.longitude = animal.longitude.doubleValue;

        Location *annotation = [[Location alloc] initWithName:animal.species subtitle:animal.habitat icon:animal.icon color:[UIColor redColor] coordinate:animalCoordinate];
        [annotations addObject:annotation];
    }
    
    return annotations;
}

@end
