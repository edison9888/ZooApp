//
//  AGFavManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 22.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGFavManager.h"
#import "AGCoreDataHelper.h"
#import "FavZooItem.h"
#import "ZooItem.h"
#import "FavEvent.h"
#import "Event.h"

@implementation AGFavManager

static AGFavManager *instance = nil;

+ (AGFavManager*) sharedInstance {
    
    @synchronized (self) {
        if (instance == nil) {
            instance = [AGFavManager new];
        }
    }
    return instance;
}

- (id) init {
    self = [super init];
    if (self) {
        self.context = [AGCoreDataHelper managedObjectContext];
    }
    
    return self;
}

- (FavZooItem*) createFavZooItemAndAddToCoreData: (ZooItem*) zooItem withType: (NSString*) type notified: (BOOL) notifiedIfClose {

    // check if animal does already exist
    if([self getFavZooItemWithName:zooItem.name] == nil) {
        
        NSLog(@"FavZooItem (%@) not yet in database. It is now being added.", zooItem);
        FavZooItem *favZooItem = [AGCoreDataHelper insertManagedObjectOfClass:[FavZooItem class] inManagedObjectContext:self.context];
        favZooItem.zooItem = zooItem;
        favZooItem.type = type;
        favZooItem.notificationIfClose = [NSNumber numberWithBool:notifiedIfClose];
        
        [AGCoreDataHelper saveManagedObjectContext:self.context];
        return favZooItem;
    
    } else {
    
        NSLog(@"FavZooItem (%@) is already in database. It will not be added.", zooItem.name);
        return nil;
    }
    
}

- (void) removeFavZooItemFromCoreData: (FavZooItem*) favZooItem {
    
    NSLog(@"FavZooItem (%@) found in database. It is now being removed.", favZooItem.zooItem.name);
    [self.context deleteObject:favZooItem];
    [AGCoreDataHelper saveManagedObjectContext:self.context];
}


- (FavZooItem*) getFavZooItemWithName: (NSString*) name {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"zooItem.name = %@", name];
    NSArray *favZooItemArray = [AGCoreDataHelper fetchEntitiesForClass:[FavZooItem class] withPredicate:predicate inManagedObjectContext:self.context];
    
    if (favZooItemArray == nil || favZooItemArray.count == 0) {
        return nil;
    }
    
    return [favZooItemArray objectAtIndex:0];
}

- (FavEvent*) createFavEventAndAddToCoreData: (Event*) event reminder: (BOOL) reminder minBeforeEvent: (NSNumber*) reminderMinBeforeEvent {
    
    // check if animal does already exist
    if([self getFavEventWithName:event.name] == nil) {
        
        NSLog(@"FavEvent (%@) not yet in database. It is now being added.", event.name);
        FavEvent *favEvent = [AGCoreDataHelper insertManagedObjectOfClass:[FavEvent class] inManagedObjectContext:self.context];
        favEvent.event = event;
        favEvent.reminder = [NSNumber numberWithBool:reminder];
        favEvent.reminderMinBeforeEvent = reminderMinBeforeEvent;
        
        [AGCoreDataHelper saveManagedObjectContext:self.context];
        return favEvent;
        
    } else {
        
        NSLog(@"FavEvent (%@) is already in database. It will not be added.", event.name);
        return nil;
    }
    
}

- (void) removeFavEventFromCoreData: (FavEvent*) favEvent {
    
    NSLog(@"FavEvent (%@) found in database. It is now being removed.", favEvent.event.name);
    [self.context deleteObject:favEvent];
    [AGCoreDataHelper saveManagedObjectContext:self.context];
}


- (FavEvent*) getFavEventWithName: (NSString*) name {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"event.name = %@", name];
    NSArray *favEventArray = [AGCoreDataHelper fetchEntitiesForClass:[FavEvent class] withPredicate:predicate inManagedObjectContext:self.context];
    
    if (favEventArray == nil || favEventArray.count == 0) {
        return nil;
    }
    
    return [favEventArray objectAtIndex:0];
}

- (NSArray*) favAnimalsArray {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", @"Animal"];
    
    return [AGCoreDataHelper fetchEntitiesForClass:[FavZooItem class] withPredicate:predicate inManagedObjectContext:self.context];
}

- (NSArray*) favRestaurantsArray {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", @"Restaurant"];
    
    return [AGCoreDataHelper fetchEntitiesForClass:[FavZooItem class] withPredicate:predicate inManagedObjectContext:self.context];
}

- (NSArray*) commentaryEventsArray {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", @"Kommentierung"];
    
    return [AGCoreDataHelper fetchEntitiesForClass:[Event class] withPredicate:predicate inManagedObjectContext:self.context];
}

- (NSArray*) feedingEventsArray {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type = %@", @"Fütterung"];
    return [AGCoreDataHelper fetchEntitiesForClass:[Event class] withPredicate:predicate inManagedObjectContext:self.context];
}

@end
