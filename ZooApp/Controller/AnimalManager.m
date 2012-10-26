//
//  AnimalManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 25.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalManager.h"

@implementation AnimalManager

static AnimalManager *instance = nil;

- (id)init
{
    self = [super init];
    if (self) {
        [self parseJSONToAnimals];
        [self categorizeAnimals];
    }
    return self;
}


+(AnimalManager*)getInstance {
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [AnimalManager new];
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
        
        Animal *animal = [Animal new];
        animal.species = [a objectForKey:@"species"];
        animal.habitat = [a objectForKey:@"habitat"];
        animal.latitude = [a objectForKey:@"latitude"];
        animal.longitude = [a objectForKey:@"longitude"];
        animal.area = [a objectForKey:@"area"];
        animal.category = [a objectForKey:@"category"];
        animal.icon = [a objectForKey:@"icon"];
        [self.allAnimals addObject:animal];

    }
    
}

- (void)categorizeAnimals {
    
    NSLog(@"Animals are being categorized");
    
    NSArray *keys = [NSArray arrayWithObjects:@"Alle Tiere", @"Säugetiere", @"Vögel", @"Reptilien", @"Amphibien", @"Wirbellose Tiere", @"Fische", @"Gründer-Garten", @"Gondwanaland", @"Asien", @"Pongoland", @"Afrika", @"Südamerika", nil]; // 13 Keys
    
    NSMutableArray *objects = [NSMutableArray new];
    for (int i = 0; i < 13; i++) {
        [objects addObject:[NSMutableArray new]];
    }
    
    self.filteredAnimalList = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];

    for (Animal *animal in self.allAnimals) {
        
        [[self.filteredAnimalList objectForKey:@"Alle Tiere"] addObject:animal];
        [[self.filteredAnimalList objectForKey:animal.category] addObject:animal];
        [[self.filteredAnimalList objectForKey:animal.area] addObject:animal];
    }    
}

# pragma mark - filter methods

- (NSArray*) getAnimalArrayForFilterKey: (NSString*) filterKey {
    
    return [self.filteredAnimalList objectForKey:filterKey];
}


@end
