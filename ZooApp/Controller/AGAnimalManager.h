//
//  AnimalManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 25.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGAnimal.h"

@interface AGAnimalManager : NSObject

@property (nonatomic, strong) NSDictionary *filteredAnimalList;
@property (nonatomic, strong) NSMutableArray *allAnimals;

+ (AGAnimalManager*)sharedInstance;

- (void)parseJSONToAnimals;
- (void)categorizeAnimals;
- (NSArray*) getAnimalArrayForFilterKey: (NSString*) filterKey;

@end

