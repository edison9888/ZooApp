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

static AGJSONParser *instance = nil;

+(AGJSONParser*)sharedInstance {
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [AGJSONParser new];
        }
    }
    return instance;
}


- (void) updateCoreDataFromJSONFiles {
    
    NSLog(@"[AGJSONParser] Start parsing JSON-Files");
    [self parseJSONFileWithName:@"animalList"];
    [self parseJSONFileWithName:@"enclosureList"];
    [self parseJSONFileWithName:@"restaurantList"];
    [self parseJSONFileWithName:@"serviceList"];
    
    if ([(AppDelegate*)[[UIApplication sharedApplication] delegate] isFirstRun]){
        [self firstRunProcedure];
    } else {
        [self updateCoreDataObjectsIfNecessary];
    }
}

- (void) parseJSONFileWithName: (NSString*) name {
    
    NSString *pathToList = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *listData = [NSData dataWithContentsOfFile:pathToList];
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:listData options:0 error:&error];
    if (error != nil) NSLog(@"[AGJSONParser] Error: %@, %@ could not be parsed", [error localizedDescription], name);
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    
    if ([name isEqualToString:@"animalList"]) {
        self.animalJSON = json;
        self.animalList = [self.animalJSON objectForKey:@"animals"];
        self.versionAnimalJSON = [f numberFromString: [self.animalJSON objectForKey:@"version"]];
    } else if ([name isEqualToString:@"enclosureList"]) {
        self.enclosureJSON = json;
        self.enclosureList = [self.enclosureJSON objectForKey:@"enclosures"];
        self.versionEnclosureJSON = [f numberFromString: [self.enclosureJSON objectForKey:@"version"]];
    } else if ([name isEqualToString:@"restaurantList"]) {
        self.restaurantJSON = json;
        self.restaurantList = [self.restaurantJSON objectForKey:@"restaurants"];
        self.versionRestaurantJSON = [f numberFromString: [self.restaurantJSON objectForKey:@"version"]];
    } else if ([name isEqualToString:@"serviceList"]) {
        self.serviceJSON = json;
        self.serviceList = [self.serviceJSON objectForKey:@"services"];
        self.versionServiceJSON = [f numberFromString: [self.serviceJSON objectForKey:@"version"]];
    }
}

- (void) firstRunProcedure {
    
    NSLog(@"[AGJSONParser] First Run Procedure");
    
    // Write use current JSON version as current CoreData version
    NSEntityDescription *animalEntityDescription = [NSEntityDescription entityForName:@"Animal" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    NSDictionary *aniDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionAnimalJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [animalEntityDescription setUserInfo:aniDict];

    NSEntityDescription *enclosureEntityDescription = [NSEntityDescription entityForName:@"Enclosure" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    NSDictionary *encDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionEnclosureJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [enclosureEntityDescription setUserInfo:encDict];
    
    NSEntityDescription *restaurantEntityDescription = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    NSDictionary *resDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionRestaurantJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [restaurantEntityDescription setUserInfo:resDict];
    
    NSEntityDescription *serviceEntityDescription = [NSEntityDescription entityForName:@"Service" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    NSDictionary *serDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionRestaurantJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [serviceEntityDescription setUserInfo:serDict];
    
    // Write lists to objects
    for (NSDictionary *a in self.restaurantList) {
        [AGJSONParser createAndAddRestaurantToCoreData: a];
    }
    


}

- (void) updateCoreDataObjectsIfNecessary {
    
    NSLog(@"[AGJSONParser] Update Procedure");
    
    self.versionAnimalCoreData = [[[NSEntityDescription entityForName:@"Animal" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] userInfo] valueForKey:@"version"];
    self.versionEnclosureCoreData = [[[NSEntityDescription entityForName:@"Enclosure" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] userInfo] valueForKey:@"version"];
    self.versionRestaurantCoreData = [[[NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] userInfo] valueForKey:@"version"];
    self.versionServiceCoreData = [[[NSEntityDescription entityForName:@"Service" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] userInfo] valueForKey:@"version"];
    
    if (self.versionAnimalJSON > self.versionAnimalCoreData) {
        // update
    }

    if (self.versionEnclosureJSON > self.versionEnclosureCoreData) {
        // update
    }

    if (self.versionRestaurantJSON > self.versionRestaurantCoreData) {
        // update
    }

    if (self.versionServiceJSON > self.versionServiceCoreData) {
        // update
    }

}


# pragma mark - save JSON dictionaries as Core Data objects

+ (Location*) createAndAddLocationToCoreDataWithLatitude: (NSString*) latitude longitude: (NSString*) longitude andArea: (NSString*) area {
    
    Location *location = [AGCoreDataHelper insertManagedObjectOfClass:[Location class] inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    location.latitude = [f numberFromString:latitude];
    location.longitude = [f numberFromString:longitude];
    location.area = area;
    
    [AGCoreDataHelper saveManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    return location;
}

+ (Marker*) createAndAddMarkerToCoreDataWithTitle: (NSString*) title subtitle: (NSString*) subtitle andIcon: (NSString*) iconPath {
    
    Marker *marker = [AGCoreDataHelper insertManagedObjectOfClass:[Marker class] inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    marker.title = title;
    marker.subtitle = subtitle;
    marker.icon = iconPath;
    
    [AGCoreDataHelper saveManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    return marker;
}

+ (void) createAndAddAnimalToCoreData: (NSDictionary*) a {
    
    
    Restaurant *restaurant = [AGCoreDataHelper insertManagedObjectOfClass:[Restaurant class] inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    /*
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
    */
    
    // create Location
    Location *location = [self createAndAddLocationToCoreDataWithLatitude:[a objectForKey:@"latitude"] longitude:[a objectForKey:@"longitude"] andArea:[a objectForKey:@"area"]];
    restaurant.location = location;
    location.zooItem = restaurant;
    
    // create Marker
    Marker *marker = [self createAndAddMarkerToCoreDataWithTitle:[a objectForKey:@"name"] subtitle:[a objectForKey:@"ambience"]andIcon:nil];
    restaurant.marker = marker;
    marker.zooItem = restaurant;
    
    [AGCoreDataHelper saveManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    

    
    
    
}

+ (void) createAndAddRestaurantToCoreData: (NSDictionary*) a {
    
    NSLog(@"[AGJSONParser] Create and add restaurant to Core Data");
    
    
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
    
    
    // create Location
    Location *location = [self createAndAddLocationToCoreDataWithLatitude:[a objectForKey:@"latitude"] longitude:[a objectForKey:@"longitude"] andArea:[a objectForKey:@"area"]];
    restaurant.location = location;
    location.zooItem = restaurant;
    
    // create Marker
    Marker *marker = [self createAndAddMarkerToCoreDataWithTitle:[a objectForKey:@"name"] subtitle:[a objectForKey:@"ambience"]andIcon:nil];
    restaurant.marker = marker;
    marker.zooItem = restaurant;
    
    [AGCoreDataHelper saveManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
}



@end
