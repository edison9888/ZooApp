//
//  AnimalManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 25.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Animal.h"

@interface AnimalManager : NSObject

typedef enum {
    FILTER_ALLANIMALS,
    FILTER_MAMMALS,
    FILTER_BIRDS,
    FILTER_REPTILES,
    FILTER_AMPHIBIANS,
    FILTER_INVERTEBRATES,
    FILTER_FISH,
    FILTER_FOUNDERSGARDEN,
    FILTER_GONDWANALAND,
    FILTER_ASIA,
    FILTER_PONGOLAND,
    FILTER_AFRICA,
    FILTER_SOUTHAMERICA
} FilterType;

@property (nonatomic, strong) NSMutableArray *allAnimals;

@property (nonatomic, strong) NSMutableArray *allMammals;
@property (nonatomic, strong) NSMutableArray *allBirds;
@property (nonatomic, strong) NSMutableArray *allReptiles;
@property (nonatomic, strong) NSMutableArray *allAmphibians;
@property (nonatomic, strong) NSMutableArray *allInvertebrates;
@property (nonatomic, strong) NSMutableArray *allFish;

@property (nonatomic, strong) NSMutableArray *allFoundersGardenAnimals;
@property (nonatomic, strong) NSMutableArray *allGondwanalandAnimals;
@property (nonatomic, strong) NSMutableArray *allAsiaAnimals;
@property (nonatomic, strong) NSMutableArray *allPongolandAnimals;
@property (nonatomic, strong) NSMutableArray *allAfricaAnimals;
@property (nonatomic, strong) NSMutableArray *allSouthAmericaAnimals;

@property (nonatomic) FilterType filterType;

+ (AnimalManager*)getInstance;

- (void)parseJSONToAnimals;
- (void)categorizeAnimals;
- (NSArray*) getAnimalArrayFromCurrentFilter;
- (NSArray*) getArrayWithFilteredAnimals: (FilterType) filter;
- (NSArray*) getAllAnimals;

@end

