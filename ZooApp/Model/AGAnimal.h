//
//  Animal.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGPoi.h"

@interface AGAnimal : AGPoi

@property (nonatomic, strong) NSString *enclosure;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *relationship;
@property (nonatomic, strong) NSString *habitat;
@property (nonatomic, strong) NSString *maximumAge;
@property (nonatomic, strong) NSString *size;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *socialStructure;
@property (nonatomic, strong) NSString *propagation;
@property (nonatomic, strong) NSString *enemies;
@property (nonatomic, strong) NSString *food;
@property (nonatomic, strong) NSString *threadState;
@property (nonatomic, strong) NSString *funFact;
@property (nonatomic, strong) NSString *image;

@end
