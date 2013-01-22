//
//  AGFavManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 22.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGFavManager.h"
#import "AGCoreDataHelper.h"
#import "AGFavAnimal.h"

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

- (AGFavAnimal*) addAnimalToFavsWithName: (NSString*) name notified: (BOOL) notifiedIfClose {

    // check if animal does already exist
    if([self getFavAnimalWithName:name] == nil) {
        
        NSLog(@"Animal (%@) not yet in database. It is now being added.", name);
        AGFavAnimal *favAnimal = [AGCoreDataHelper insertManagedObjectOfClass:[AGFavAnimal class] inManagedObjectContext:self.context];
        favAnimal.name = name;
        favAnimal.notificationIfClose = [NSNumber numberWithBool:notifiedIfClose];
        [AGCoreDataHelper saveManagedObjectContext:self.context];
        return favAnimal;
    
    } else {
    
        NSLog(@"Animal (%@) is already in database. It will not be added.", name);
        return nil;
    }
    
}

- (void) removeAnimalFromFavsWithName: (NSString*) name {
    
    AGFavAnimal *favAnimal = [self getFavAnimalWithName:name] ;
    
    // check if animal does already exist
    if (favAnimal != nil) {
        
        NSLog(@"Animal (%@) found in database. It is now being removed.", name);
        [self.context deleteObject:favAnimal];
        [AGCoreDataHelper saveManagedObjectContext:self.context];
        
    } else {
     
        NSLog(@"Animal (%@) not found in database. It cannot be removed.", name);
    }

}


- (AGFavAnimal*) getFavAnimalWithName: (NSString*) name {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    AGFavAnimal *favAnimal = [[AGCoreDataHelper fetchEntitiesForClass:[AGFavAnimal class] withPredicate:predicate inManagedObjectContext:self.context] objectAtIndex:0];
    
    return favAnimal;
}

- (NSArray*) favouriteAnimalsArray {
    
    return [AGCoreDataHelper fetchEntitiesForClass:[AGFavAnimal class] withPredicate:nil inManagedObjectContext:self.context];
}

@end
