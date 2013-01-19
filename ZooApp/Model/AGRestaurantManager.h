//
//  AGRestaurantManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 19.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGRestaurantManager : NSObject

@property (nonatomic, strong) NSMutableArray *allRestaurants;

+ (AGRestaurantManager*)getInstance;

- (void)parseJSONToRestaurants;

@end
