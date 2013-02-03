//
//  AGJSONParser.h
//  ZooApp
//
//  Created by Andrea Gerlach on 01.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGJSONParser : NSObject

@property (nonatomic, retain) NSManagedObjectContext *context;

@property (nonatomic, strong) NSDictionary* eventJSON;
@property (nonatomic, strong) NSDictionary* eventList;
@property (nonatomic, strong) NSNumber* versionEventJSON;
@property (nonatomic, strong) NSNumber* versionEventCoreData;

@property (nonatomic, strong) NSDictionary* animalJSON;
@property (nonatomic, strong) NSDictionary* animalList;
@property (nonatomic, strong) NSNumber* versionAnimalJSON;
@property (nonatomic, strong) NSNumber* versionAnimalCoreData;

@property (nonatomic, strong) NSDictionary* enclosureJSON;
@property (nonatomic, strong) NSDictionary* enclosureList;
@property (nonatomic, strong) NSNumber* versionEnclosureJSON;
@property (nonatomic, strong) NSNumber* versionEnclosureCoreData;

@property (nonatomic, strong) NSDictionary* restaurantJSON;
@property (nonatomic, strong) NSDictionary* restaurantList;
@property (nonatomic, strong) NSNumber* versionRestaurantJSON;
@property (nonatomic, strong) NSNumber* versionRestaurantCoreData;

@property (nonatomic, strong) NSDictionary* serviceJSON;
@property (nonatomic, strong) NSDictionary* serviceList;
@property (nonatomic, strong) NSNumber* versionServiceJSON;
@property (nonatomic, strong) NSNumber* versionServiceCoreData;

+ (AGJSONParser*)sharedInstance;
- (void) updateCoreDataFromJSONFiles;

@end
