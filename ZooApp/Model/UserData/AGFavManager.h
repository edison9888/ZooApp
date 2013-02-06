//
//  AGFavManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 22.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavZooItem.h"
#import "FavEvent.h"

@interface AGFavManager : NSObject


@property (nonatomic, retain) NSManagedObjectContext *context;

+ (AGFavManager*) sharedInstance;

- (NSArray*) favAnimalsArray;
- (NSArray*) favRestaurantsArray;

- (FavZooItem*) createFavZooItemAndAddToCoreData: (ZooItem*) zooItem withType: (NSString*) type notified: (BOOL) notifiedIfClose;
- (void) removeFavZooItemFromCoreData: (FavZooItem*) favZooItem;
- (FavZooItem*) getFavZooItemWithName: (NSString*) name;


- (FavEvent*) createFavEventAndAddToCoreData: (Event*) event reminder: (BOOL) reminder minBeforeEvent: (NSNumber*) reminderMinBeforeEvent;
- (void) removeFavEventFromCoreData: (FavEvent*) favEvent;
- (FavEvent*) getFavEventWithName: (NSString*) name;

@end
