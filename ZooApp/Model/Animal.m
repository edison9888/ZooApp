//
//  Animal.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "Animal.h"

static NSMutableArray *allAnimals;

@implementation Animal 

+ (void) parseJSONToAnimals {
    
    NSLog(@"JSON will be parsed to animals");
    
    NSString *pathToAnimalList = [[NSBundle mainBundle] pathForResource:@"animalList" ofType:@"json"];
    NSData *animalListData = [NSData dataWithContentsOfFile:pathToAnimalList];
    NSError *error;
    NSDictionary *animalListJSON = [NSJSONSerialization JSONObjectWithData:animalListData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Fehler: %@", [error localizedDescription]);
    }
    
    NSArray *animalArrayJSON = [animalListJSON objectForKey:@"animals"];
    
    allAnimals = [NSMutableArray new];
    
    for (NSDictionary *a in animalArrayJSON) {
  
        Animal *animal = [Animal new];
        animal.species = [a objectForKey:@"species"];
        animal.habitat = [a objectForKey:@"habitat"];
        animal.latitude = [a objectForKey:@"latitude"];
        animal.longitude = [a objectForKey:@"longitude"];
        animal.icon = [a objectForKey:@"icon"];
        [allAnimals addObject:animal];
    
    }

}

+ (NSArray *)getAllAnimals {
   
    return allAnimals;
}

@end
