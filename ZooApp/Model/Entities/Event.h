//
//  Event.h
//  ZooApp
//
//  Created by Andrea Gerlach on 03.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZooItem;

@interface Event : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) ZooItem *zooItem;

@end
