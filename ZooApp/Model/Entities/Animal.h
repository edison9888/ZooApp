//
//  Animal.h
//  ZooApp
//
//  Created by Andrea Gerlach on 03.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ZooItem.h"

@class Enclosure;

@interface Animal : ZooItem

@property (nonatomic, retain) NSString * category;
@property (nonatomic, retain) NSString * enemies;
@property (nonatomic, retain) NSString * food;
@property (nonatomic, retain) NSString * funFact;
@property (nonatomic, retain) NSString * habitat;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * maximumAge;
@property (nonatomic, retain) NSString * propagation;
@property (nonatomic, retain) NSString * relationship;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * socialStructure;
@property (nonatomic, retain) NSString * threadState;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) Enclosure *enclosure;

@end
