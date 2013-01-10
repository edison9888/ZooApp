//
//  MarkerManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "MarkerManager.h"
#import "AGAnimal.h"
#import "AnimalManager.h"


@implementation MarkerManager

+ (NSArray*) createAllAnimalMarkers {
    
    NSMutableArray *annotations = [NSMutableArray new];
    [annotations removeAllObjects];
    
    for (AGAnimal *animal in [AnimalManager getInstance].allAnimals) {
        
        CLLocationCoordinate2D animalCoordinate;
        animalCoordinate.latitude = animal.latitude.doubleValue;
        animalCoordinate.longitude = animal.longitude.doubleValue;

        Location *annotation = [[Location alloc] initWithName:animal.name subtitle:animal.habitat icon:animal.image color:[UIColor greenColor] coordinate:animalCoordinate];
        
        [annotations addObject:annotation];
    }
    
    return annotations;
}

+ (Location*) createMarkerForAnimal: (AGAnimal*) animal {
    
    CLLocationCoordinate2D animalCoordinate;
    animalCoordinate.latitude = animal.latitude.doubleValue;
    animalCoordinate.longitude = animal.longitude.doubleValue;
        
    Location *annotation = [[Location alloc] initWithName:animal.name subtitle:animal.enclosure icon:animal.image color:[UIColor greenColor] coordinate:animalCoordinate];
    
    
    
    return annotation;
}

@end
