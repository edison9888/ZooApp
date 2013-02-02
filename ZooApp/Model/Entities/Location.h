//
//  Location.h
//  ZooApp
//
//  Created by Andrea Gerlach on 01.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZooItem;

@interface Location : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) ZooItem *zooItem;

@end
