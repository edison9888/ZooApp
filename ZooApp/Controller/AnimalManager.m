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
         self.filterType = FILTER_ALLANIMALS;
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
        
    self.allMammals = [NSMutableArray new];
    self.allBirds = [NSMutableArray new];
    self.allReptiles = [NSMutableArray new];
    self.allAmphibians = [NSMutableArray new];
    self.allInvertebrates = [NSMutableArray new];
    self.allFish = [NSMutableArray new];
    
    self.allFoundersGardenAnimals = [NSMutableArray new];
    self.allGondwanalandAnimals = [NSMutableArray new];
    self.allAsiaAnimals = [NSMutableArray new];
    self.allPongolandAnimals = [NSMutableArray new];
    self.allAfricaAnimals = [NSMutableArray new];
    self.allSouthAmericaAnimals = [NSMutableArray new];
    
    for (Animal *animal in self.allAnimals) {
        
        if ([animal.category isEqualToString:@"Säugetiere"]) {
            [self.allMammals addObject:animal];
        } else if ([animal.category isEqualToString:@"Vögel"]) {
            [self.allBirds addObject:animal];
        } else if ([animal.category isEqualToString:@"Reptilien"]) {
            [self.allReptiles addObject:animal];
        } else if ([animal.category isEqualToString:@"Amphibien"]) {
            [self.allAmphibians addObject:animal];
        } else if ([animal.category isEqualToString:@"Wirbellose Tiere"]) {
            [self.allInvertebrates addObject:animal];
        } else if ([animal.category isEqualToString:@"Fische"]) {
            [self.allFish addObject:animal];
        }
        
        if ([animal.area isEqualToString:@"Gründer-Garten"]) {
            [self.allFoundersGardenAnimals addObject:animal];
        } else if ([animal.area isEqualToString:@"Gondwanaland"]) {
            [self.allGondwanalandAnimals addObject:animal];
        } else if ([animal.area isEqualToString:@"Asien"]) {
            [self.allAsiaAnimals addObject:animal];
        } else if ([animal.area isEqualToString:@"Pongoland"]) {
            [self.allPongolandAnimals addObject:animal];
        } else if ([animal.area isEqualToString:@"Afrika"]) {
            [self.allAfricaAnimals addObject:animal];
        } else if ([animal.area isEqualToString:@"Südamerika"]) {
            [self.allSouthAmericaAnimals addObject:animal];
        }
    }
    
}

# pragma mark - filter methods

- (NSArray*) getAnimalArrayFromCurrentFilter {
    return [self getArrayWithFilteredAnimals:self.filterType];
}

- (NSArray*) getArrayWithFilteredAnimals: (FilterType) filter {
    
    switch (filter) {
        case FILTER_MAMMALS:
            return self.allMammals;
            break;
        case FILTER_BIRDS:
            return self.allBirds;
            break;
        case FILTER_REPTILES:
            return self.allReptiles;
            break;
        case FILTER_AMPHIBIANS:
            return self.allAmphibians;
            break;
        case FILTER_INVERTEBRATES:
            return self.allInvertebrates;
            break;
        case FILTER_FISH:
            return self.allFish;
            break;
        case FILTER_FOUNDERSGARDEN:
            return self.allFoundersGardenAnimals;
            break;
        case FILTER_GONDWANALAND:
            return self.allGondwanalandAnimals;
            break;
        case FILTER_ASIA:
            return self.allAsiaAnimals;
            break;
        case FILTER_PONGOLAND:
            return self.allPongolandAnimals;
            break;
        case FILTER_AFRICA:
            return self.allAfricaAnimals;
            break;
        case FILTER_SOUTHAMERICA:
            return self.allSouthAmericaAnimals;
            break;
        default: //ALLANIMALS OR NIL
            return self.allAnimals;
            break;
    }
}


- (NSArray*) getAllAnimals {
    return self.allAnimals;
}

@end
