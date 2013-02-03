//
//  ZooItem.h
//  ZooApp
//
//  Created by Andrea Gerlach on 03.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event, Location, Marker;

@interface ZooItem : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *event;
@property (nonatomic, retain) Location *location;
@property (nonatomic, retain) Marker *marker;
@end

@interface ZooItem (CoreDataGeneratedAccessors)

- (void)addEventObject:(Event *)value;
- (void)removeEventObject:(Event *)value;
- (void)addEvent:(NSSet *)values;
- (void)removeEvent:(NSSet *)values;

@end
