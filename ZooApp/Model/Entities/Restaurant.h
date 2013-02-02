//
//  Restaurant.h
//  ZooApp
//
//  Created by Andrea Gerlach on 01.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "ZooItem.h"


@interface Restaurant : ZooItem

@property (nonatomic, retain) NSString * catering;
@property (nonatomic, retain) NSString * seats;
@property (nonatomic, retain) NSString * openingHours;
@property (nonatomic, retain) NSString * ambience;
@property (nonatomic, retain) NSString * food;
@property (nonatomic, retain) NSString * additionalInfo;
@property (nonatomic, retain) NSString * bookingPhone;
@property (nonatomic, retain) NSString * image;

@end
