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
        
        animal.name = [a objectForKey:@"name"];
        animal.latitude = [a objectForKey:@"latitude"];
        animal.longitude = [a objectForKey:@"longitude"];
        animal.area = [a objectForKey:@"area"];
        animal.category = [a objectForKey:@"category"];
        animal.verwandschaft = [a objectForKey:@"verwandschaft"];
        animal.lebensraum = [a objectForKey:@"lebensraum"];
        animal.hoechstalter = [a objectForKey:@"hoechstalter"];
        animal.groesse = [a objectForKey:@"groesse"];
        animal.gewicht = [a objectForKey:@"gewicht"];
        animal.sozialstruktur = [a objectForKey:@"sozialstruktur"];
        animal.fortpflanzung = [a objectForKey:@"fortpflanzung"];
        animal.feinde = [a objectForKey:@"feinde"];
        animal.nahrung = [a objectForKey:@"nahrung"];
        animal.bedrohungsstatus = [a objectForKey:@"bedrohungsstatus"];
        animal.image = [a objectForKey:@"image"];
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
    for (Animal *animal in self.allAnimals) {
        
        [[self.filteredAnimalList objectForKey:animal.category] addObject:animal];
        [[self.filteredAnimalList objectForKey:animal.area] addObject:animal];
    }
    
}

# pragma mark - filter methods

- (NSArray*) getAnimalArrayForFilterKey: (NSString*) filterKey {
    
    return [self.filteredAnimalList objectForKey:filterKey];
}


@end
