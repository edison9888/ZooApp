//
//  AnimalManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 25.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGAnimalManager.h"
#import "AGLocation.h"

@implementation AGAnimalManager

static AGAnimalManager *instance = nil;

- (id)init
{
    self = [super init];
    if (self) {
        [self parseJSONToAnimals];
        [self categorizeAnimals];
    }
    return self;
}


+(AGAnimalManager*)getInstance {
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [AGAnimalManager new];
        }
    }
    return instance;
}


#pragma mark - init methods

- (void)parseJSONToAnimals {
    
    NSLog(@"Animals are being parsed from JSON");
    
    NSString *pathToAnimalList = [[NSBundle mainBundle] pathForResource:@"animalList" ofType:@"json"];
    NSData *animalListData = [NSData dataWithContentsOfFile:pathToAnimalList];
    NSError *error;
    NSDictionary *animalListJSON = [NSJSONSerialization JSONObjectWithData:animalListData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Fehler: %@", [error localizedDescription]);
    }
    
    NSArray *animalArrayJSON = [animalListJSON objectForKey:@"animals"];
    
    self.allAnimals = [NSMutableArray new];
    
    for (NSDictionary *a in animalArrayJSON) {
        
        AGAnimal *animal = [AGAnimal new];
        
        animal.name = [a objectForKey:@"name"];
        animal.latitude = [a objectForKey:@"latitude"];
        animal.longitude = [a objectForKey:@"longitude"];
        
        CLLocationCoordinate2D animalCoordinate;
        animalCoordinate.latitude = [[a objectForKey:@"latitude"] doubleValue];
        animalCoordinate.longitude = [[a objectForKey:@"longitude"] doubleValue];
        AGLocation *location = [[AGLocation alloc] initLocationWithCoordinate:animalCoordinate];
        
        animal.location = location;
        animal.area = [a objectForKey:@"area"];
        animal.enclosure = [a objectForKey:@"enclosure"];
        animal.feedingTime = [a objectForKey:@"feedingTime"];
        animal.commentaryTime = [a objectForKey:@"commentaryTime"];
        animal.category = [a objectForKey:@"category"];
        animal.relationship = [a objectForKey:@"relationship"];
        animal.habitat = [a objectForKey:@"habitat"];
        animal.maximumAge = [a objectForKey:@"maximumAge"];
        animal.size = [a objectForKey:@"size"];
        animal.weight = [a objectForKey:@"weight"];
        animal.socialStructure = [a objectForKey:@"socialStructure"];
        animal.propagation = [a objectForKey:@"propagation"];
        animal.enemies = [a objectForKey:@"enemies"];
        animal.food = [a objectForKey:@"food"];
        animal.threadState = [a objectForKey:@"threadState"];
        animal.funFact = [a objectForKey:@"funFact"];
        animal.image = [a objectForKey:@"image"];
        
        [animal.location setAnnotationForLocationWithName:animal.name subtitle:animal.habitat image:animal.image color:MKPinAnnotationColorGreen];
        
        [self.allAnimals addObject:animal];

    }
    
}

- (void)categorizeAnimals {
    
    NSLog(@"Animals are being categorized");
    
    // define a key array and add 13 keys
    NSArray *keys = [NSArray arrayWithObjects:@"Alle Tiere", @"Säugetiere", @"Vögel", @"Reptilien", @"Amphibien", @"Wirbellose Tiere", @"Fische", @"Gründer-Garten", @"Gondwanaland", @"Asien", @"Pongoland", @"Afrika", @"Südamerika", nil];
    
    // define an object array which will be corresponding to the keys
    NSMutableArray *objects = [NSMutableArray new];
    
    // add an array with all animals as the first object, corresponding to the first key "Alle Tiere"
    [objects addObject:self.allAnimals];
    
    // add 12 empty arrays for the objects of the other keys
    for (int i = 0; i < 12; i++) {
        [objects addObject:[NSMutableArray new]];
    }
    
    // initialize a new dictionary with keys and objects
    self.filteredAnimalList = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    
    // put all animals in their corresponding arrays
    for (AGAnimal *animal in self.allAnimals) {
        
        [[self.filteredAnimalList objectForKey:animal.category] addObject:animal];
        [[self.filteredAnimalList objectForKey:animal.area] addObject:animal];
    }
    
}

# pragma mark - filter methods

- (NSArray*) getAnimalArrayForFilterKey: (NSString*) filterKey {
    
    return [self.filteredAnimalList objectForKey:filterKey];
}


@end
