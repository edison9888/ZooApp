//
//  AGCoreDataHelper.m
//  ZooApp
//
//  Created by Andrea Gerlach on 21.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGCoreDataHelper.h"

@implementation AGCoreDataHelper

+ (NSString*) directoryForDatabaseFilename {
    
    return [NSHomeDirectory() stringByAppendingString:@"/Library/Private Documents"];
}

+ (NSString*) databaseFilename {

    return @"database.sqlite";
}

+ (NSManagedObjectContext*) managedObjectContext {

    static NSManagedObjectContext *managedObjectContext;
    
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    NSError *error;
    
    // creates directory
    [[NSFileManager defaultManager] createDirectoryAtPath:[AGCoreDataHelper directoryForDatabaseFilename] withIntermediateDirectories:YES attributes:nil error:&error];
    
    if (error) {
        NSLog(@"Fehler; %@", [error localizedDescription]);
        return nil;
    }
    
    // creates complete path for database file
    NSString *path = [NSString stringWithFormat:@"%@/%@", [AGCoreDataHelper directoryForDatabaseFilename], [AGCoreDataHelper databaseFilename]];
    
    // creates url from path
    NSURL *url = [NSURL fileURLWithPath:path];
    
    // creates object model from several models if neccessary
    NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    
    // creates persistant store coordinator with managed object model
    NSPersistentStoreCoordinator *storeCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
    
    // initialize store coordinator with database file
    if (! [storeCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error]) {
        NSLog(@"Fehler; %@", [error localizedDescription]);
        return nil;
    }
    
    // create managed object context with store coordinator
    managedObjectContext = [NSManagedObjectContext new];
    managedObjectContext.persistentStoreCoordinator = storeCoordinator;
    
    return managedObjectContext;
}

+ (id)insertManagedObjectOfClass: (Class) agClass inManagedObjectContext: (NSManagedObjectContext*) managedObjectContext {
    
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass(agClass) inManagedObjectContext:managedObjectContext];
    
    return managedObject;
}

+ (BOOL) saveManagedObjectContext: (NSManagedObjectContext*) managedObjectContext {

    NSError *error;
    
    if (! [managedObjectContext save:&error]) {
        NSLog(@"Failed to save to data store: %@", [error localizedDescription]);
		NSArray* detailedErrors = [[error userInfo] objectForKey:NSDetailedErrorsKey];
		if(detailedErrors != nil && [detailedErrors count] > 0) {
			for(NSError* detailedError in detailedErrors) {
				NSLog(@"  DetailedError: %@", [detailedError userInfo]);
			}
		}
		else {
			NSLog(@"  %@", [error userInfo]);
		}
    }
    
    return YES;
}

+ (NSArray*) fetchEntitiesForClass: (Class) agClass withPredicate: (NSPredicate*) predicate inManagedObjectContext: (NSManagedObjectContext*) managedObjectContext {
    
    NSError *error;
    
    NSFetchRequest *fetchRequest = [NSFetchRequest new];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass(agClass) inManagedObjectContext:managedObjectContext];
    fetchRequest.entity = entityDescription;
    fetchRequest.predicate = predicate;
    
    NSArray *items = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (error) {
        NSLog(@"Fehler; %@", [error localizedDescription]);
        return nil;
    } else if (items.count == 0) {
       // NSLog(@"zero results for %@", predicate);
        return nil;
    }
    
    return items;
}

+ (BOOL) performFetchOnFetchedResultsController: (NSFetchedResultsController*) fetchedResultsController {
    
    NSError *error;
    if (! [fetchedResultsController performFetch:&error]) {
        NSLog(@"Fehler; %@", [error localizedDescription]);
        return NO;
    }
    return  YES;
    
}

@end
