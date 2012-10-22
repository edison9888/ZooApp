//
//  Animal.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (nonatomic, strong) NSString *species;
@property (nonatomic, strong) NSString *habitat;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *icon;

+ (void) parseJSONToAnimals;
+ (NSArray*) getAllAnimals;

@end
