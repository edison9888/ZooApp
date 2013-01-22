//
//  AGFavManager.h
//  ZooApp
//
//  Created by Andrea Gerlach on 22.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGFavAnimal.h"

@interface AGFavManager : NSObject

@property (nonatomic, retain) NSManagedObjectContext *context;

+ (AGFavManager*) sharedInstance;

- (NSArray*) favouriteAnimalsArray;

- (AGFavAnimal*) addAnimalToFavsWithName: (NSString*) name notified: (BOOL) notifiedIfClose;
- (void) removeAnimalFromFavsWithName: (NSString*) name;

- (AGFavAnimal*) getFavAnimalWithName: (NSString*) name;

@end
