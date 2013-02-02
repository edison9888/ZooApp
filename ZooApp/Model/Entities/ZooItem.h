//
//  ZooItem.h
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Location, Marker;

@interface ZooItem : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Marker *marker;

@end
