//
//  AGJSONParser.m
//  ZooApp
//
//  Created by Andrea Gerlach on 01.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGJSONParser.h"
#import "AGCoreDataHelper.h"
#import "Restaurant.h"
#import "Location.h"
#import "Marker.h"
#import "AppDelegate.h"

@implementation AGJSONParser

+ (void) parseRestaurantJSON {
    
    NSLog(@"[AGJSONParser] Start parsing restaurantList.json");
 
    NSString *pathToRestaurantList = [[NSBundle mainBundle] pathForResource:@"restaurantList" ofType:@"json"];
    NSData *restaurantListData = [NSData dataWithContentsOfFile:pathToRestaurantList];
    NSError *error;
    NSDictionary *restaurantListJSON = [NSJSONSerialization JSONObjectWithData:restaurantListData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"[AGJSONParser] Fehler: %@, restaurant.json could not be parsed", [error localizedDescription]);
        return;
    }
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    NSNumber *versionNumberCoreData = [[entityDescription userInfo] valueForKey:@"version"];
    NSNumber *versionNumberJSON = (NSNumber*)[restaurantListJSON objectForKey:@"version"];
    NSArray *restaurantArrayJSON = [restaurantListJSON objectForKey:@"restaurants"];


    if ([(AppDelegate*)[[UIApplication sharedApplication] delegate] isFirstRun]){
        NSLog(@"XXXXXXX FIRST RUN XXXXXXXX");
        NSDictionary *dict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:versionNumberJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
        [entityDescription setUserInfo:dict];
        NSLog(@"[AGJSONParser] Write JSON to Restaurant Objects");
        for (NSDictionary *a in restaurantArrayJSON) {
            [AGJSONParser writeJSONDictionaryToRestaurantObject: a];
        }
    } else {
        NSLog(@"XXXXXXXX NOT FIRST RUN XXXXXXXX");
        if (versionNumberJSON > versionNumberCoreData) {
            for (NSDictionary *a in restaurantArrayJSON) {
                NSLog(@"[AGJSONParser] Update Restaurant Objects from JSON");
            //  [AGJSONParser writeJSONDictionaryToRestaurantObject: a];
            }
     } else {
            return;
        }
    }
    
    NSArray *restaurantsInCoreData = [AGCoreDataHelper fetchEntitiesForClass:[Restaurant class] withPredicate:nil inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    
    NSLog(@"XXXXXXXX RestaurantsInCoreData %@" , restaurantsInCoreData);


}

+ (void) writeJSONDictionaryToRestaurantObject: (NSDictionary*) a {
    
    
    Location *location = [AGCoreDataHelper insertManagedObjectOfClass:[Location class] inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    location.latitude = [f numberFromString:[a objectForKey:@"latitude"]];
    location.longitude = [f numberFromString:[a objectForKey:@"longitude"]];
    location.area = [a objectForKey:@"area"];
  
    Marker *marker = [AGCoreDataHelper insertManagedObjectOfClass:[Marker class] inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    marker.title = [a objectForKey:@"name"];
    marker.subtitle = [a objectForKey:@"ambience"];
    marker.icon = nil;
    
    Restaurant *restaurant = [AGCoreDataHelper insertManagedObjectOfClass:[Restaurant class] inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    restaurant.name = [a objectForKey:@"name"];
    restaurant.catering = [a objectForKey:@"catering"];
    restaurant.seats = [a objectForKey:@"seats"];
    restaurant.openingHours = [a objectForKey:@"openingHours"];
    restaurant.ambience = [a objectForKey:@"ambience"];
    restaurant.food = [a objectForKey:@"food"];
    restaurant.additionalInfo = [a objectForKey:@"additionalInfo"];
    restaurant.bookingPhone = [a objectForKey:@"bookingPhone"];
    restaurant.image = [a objectForKey:@"image"];
    
    [AGCoreDataHelper saveManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    restaurant.location = location;
    location.zooItem = restaurant;

    restaurant.marker = marker;
    marker.zooItem = restaurant;
    
    [AGCoreDataHelper saveManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
        
}



@end
