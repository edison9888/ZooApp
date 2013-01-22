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

- (void) addAnimalToFavsWithName: (NSString*) name notified: (BOOL) notifiedIfClose {

    // check if animal does already exist --> this should never be the case, just a precaution
    if(![self checkIfFavsContainAnimalWithName:name]) {
        NSLog(@"Animal (%@) is now being added.", name);
        AGFavAnimal *favAnimal = [AGCoreDataHelper insertManagedObjectOfClass:[AGFavAnimal class] inManagedObjectContext:self.context];
        favAnimal.name = name;
        favAnimal.notificationIfClose = [NSNumber numberWithBool:notifiedIfClose];
        [AGCoreDataHelper saveManagedObjectContext:self.context];

    } else {
         NSLog(@"Animal (%@) will not be added.", name);
    }
    

}


- (BOOL) checkIfFavsContainAnimalWithName: (NSString*) name {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    if(![AGCoreDataHelper fetchEntitiesForClass:[AGFavAnimal class] withPredicate:predicate inManagedObjectContext:self.context]) {
        NSLog(@"Animal (%@) not found in database.", name);
        return NO;
    } else {
        NSLog(@"Animal (%@) found in database.", name);
        return YES;
    }
  
}

- (NSArray*) favouriteAnimalsArray {
    
    return [AGCoreDataHelper fetchEntitiesForClass:[AGFavAnimal class] withPredicate:nil inManagedObjectContext:self.context];
}

@end
