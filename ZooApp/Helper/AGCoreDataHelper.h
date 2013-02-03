//
//  AGCoreDataHelper.h
//  ZooApp
//
//  Created by Andrea Gerlach on 21.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface AGCoreDataHelper : NSObject

+ (NSString*) directoryForDatabaseFilename;
+ (NSString*) databaseFilename;

+ (NSManagedObjectContext*) managedObjectContext;

+ (id) insertManagedObjectOfClass: (Class) agClass inManagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

+ (BOOL) saveManagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

+ (NSArray*) fetchEntitiesForClass: (Class) agClass withPredicate: (NSPredicate*) predicate inManagedObjectContext: (NSManagedObjectContext*) managedObjectContext;

+ (BOOL) performFetchOnFetchedResultsController: (NSFetchedResultsController*) fetchedResultsController;

@end
