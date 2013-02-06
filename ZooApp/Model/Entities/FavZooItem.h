//
//  FavZooItem.h
//  ZooApp
//
//  Created by Andrea Gerlach on 06.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ZooItem;

@interface FavZooItem : NSManagedObject

@property (nonatomic, retain) NSNumber * notificationIfClose;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) ZooItem *zooItem;

@end
