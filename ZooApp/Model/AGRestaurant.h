//
//  AGRestaurant.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGLocation.h"

@interface AGRestaurant : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) AGLocation *location;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *catering;
@property (nonatomic, strong) NSString *seats;
@property (nonatomic, strong) NSString *openingHours;
@property (nonatomic, strong) NSString *ambience;
@property (nonatomic, strong) NSString *food;
@property (nonatomic, strong) NSString *additionalInfo;
@property (nonatomic, strong) NSString *bookingPhone;
@property (nonatomic, strong) NSString *image;

@end
