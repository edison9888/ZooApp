//
//  Enclosure.h
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ZooItem.h"

@class Animal;

@interface Enclosure : ZooItem

@property (nonatomic, retain) NSString * additionalInfo;
@property (nonatomic, retain) NSSet *animals;
@end

@interface Enclosure (CoreDataGeneratedAccessors)

- (void)addAnimalsObject:(Animal *)value;
- (void)removeAnimalsObject:(Animal *)value;
- (void)addAnimals:(NSSet *)values;
- (void)removeAnimals:(NSSet *)values;

@end
