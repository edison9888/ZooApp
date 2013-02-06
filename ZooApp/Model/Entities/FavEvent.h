//
//  FavEvent.h
//  ZooApp
//
//  Created by Andrea Gerlach on 06.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Event;

@interface FavEvent : NSManagedObject

@property (nonatomic, retain) NSNumber * reminder;
@property (nonatomic, retain) NSNumber * reminderMinBeforeEvent;
@property (nonatomic, retain) Event *event;

@end
