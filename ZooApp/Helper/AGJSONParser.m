//
//  AGJSONParser.m
//  ZooApp
//
//  Created by Andrea Gerlach on 01.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AppDelegate.h"
#import "AGJSONParser.h"
#import "AGCoreDataHelper.h"
#import "Animal.h"
#import "Enclosure.h"
#import "Restaurant.h"
#import "Service.h"
#import "Location.h"
#import "Marker.h"
#import "Event.h"

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

- (id) init {
    self = [super init];
    if (self) {
        self.context = [AGCoreDataHelper managedObjectContext];
    }
    
    return self;
}

- (void) updateCoreDataFromJSONFiles {
    
    NSLog(@"[AGJSONParser] Start parsing JSON-Files");
    [self parseJSONFileWithName:@"eventList"];
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
    
    if ([name isEqualToString:@"eventList"]) {
        self.eventJSON = json;
        self.eventList = [self.eventJSON objectForKey:@"events"];
        self.versionEventJSON = [f numberFromString: [self.eventJSON objectForKey:@"version"]];
    } else if ([name isEqualToString:@"animalList"]) {
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
    NSEntityDescription *eventEntityDescription = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.context];
    NSDictionary *evDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionEventJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [eventEntityDescription setUserInfo:evDict];
       
    
    NSEntityDescription *animalEntityDescription = [NSEntityDescription entityForName:@"Animal" inManagedObjectContext:self.context];
    NSDictionary *aniDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionAnimalJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [animalEntityDescription setUserInfo:aniDict];
    
    NSEntityDescription *enclosureEntityDescription = [NSEntityDescription entityForName:@"Enclosure" inManagedObjectContext:self.context];
    NSDictionary *encDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionEnclosureJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [enclosureEntityDescription setUserInfo:encDict];
    
    NSEntityDescription *restaurantEntityDescription = [NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:self.context];
    NSDictionary *resDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionRestaurantJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [restaurantEntityDescription setUserInfo:resDict];
    
    NSEntityDescription *serviceEntityDescription = [NSEntityDescription entityForName:@"Service" inManagedObjectContext:self.context];
    NSDictionary *serDict = [[NSDictionary alloc] initWithObjects:[[NSArray alloc] initWithObjects:self.versionRestaurantJSON, nil] forKeys:[[NSArray alloc] initWithObjects:@"version", nil]];
    [serviceEntityDescription setUserInfo:serDict];
    
    // Write lists to objects
    for (NSDictionary *a in self.eventList) {
        [self createAndAddEventToCoreData: a];
    }
    for (NSDictionary *a in self.enclosureList) {
        [self createAndAddEnclosureToCoreData: a];
    }
    for (NSDictionary *a in self.animalList) {
        [self createAndAddAnimalToCoreData: a];
    }
    for (NSDictionary *a in self.restaurantList) {
        [self createAndAddRestaurantToCoreData: a];
    }
    for (NSDictionary *a in self.serviceList) {
        [self createAndAddServiceToCoreData: a];
    }

}

- (void) updateCoreDataObjectsIfNecessary {
    
    NSLog(@"[AGJSONParser] Update Procedure");
    
    self.versionAnimalCoreData = [[[NSEntityDescription entityForName:@"Animal" inManagedObjectContext:self.context] userInfo] valueForKey:@"version"];
    self.versionEnclosureCoreData = [[[NSEntityDescription entityForName:@"Enclosure" inManagedObjectContext:self.context] userInfo] valueForKey:@"version"];
    self.versionRestaurantCoreData = [[[NSEntityDescription entityForName:@"Restaurant" inManagedObjectContext:self.context] userInfo] valueForKey:@"version"];
    self.versionServiceCoreData = [[[NSEntityDescription entityForName:@"Service" inManagedObjectContext:self.context] userInfo] valueForKey:@"version"];
    
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

- (Location*) createAndAddLocationToCoreDataWithLatitude: (NSString*) latitude longitude: (NSString*) longitude andArea: (NSString*) area {
    
    Location *location = [AGCoreDataHelper insertManagedObjectOfClass:[Location class] inManagedObjectContext:self.context];
    
    NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    location.latitude = [f numberFromString:latitude];
    location.longitude = [f numberFromString:longitude];
    location.area = area;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    return location;
}

- (Marker*) createAndAddMarkerToCoreDataWithTitle: (NSString*) title subtitle: (NSString*) subtitle andIcon: (NSString*) iconPath {
    
    Marker *marker = [AGCoreDataHelper insertManagedObjectOfClass:[Marker class] inManagedObjectContext:self.context];
    
    marker.title = title;
    marker.subtitle = subtitle;
    marker.icon = iconPath;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    return marker;
}

- (void) createAndAddEventToCoreData: (NSDictionary*) a {
    
    Event *event = [AGCoreDataHelper insertManagedObjectOfClass:[Event class] inManagedObjectContext:self.context];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"HH:mm"];
    
    NSString *timeStringJ = [a objectForKey:@"time"];
    NSDate *date = [dateFormat dateFromString:timeStringJ];

    event.name = [a objectForKey:@"name"];
    event.type = [a objectForKey:@"type"];
    event.time = date;
    
    // get ZooItem
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", [a objectForKey:@"location"]];
    ZooItem *zooItem = [[AGCoreDataHelper fetchEntitiesForClass:[ZooItem class] withPredicate:predicate inManagedObjectContext:self.context] objectAtIndex:0];
    event.zooItem = zooItem;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
}

# pragma mark - save JSON dictionaries of ZooItems as Core Data objects

- (void) createAndAddAnimalToCoreData: (NSDictionary*) a {
    
  //  NSLog(@"[AGJSONParser] createAndAddAnimalToCoreData");

    // create Location
    Location *location = [self createAndAddLocationToCoreDataWithLatitude:[a objectForKey:@"latitude"] longitude:[a objectForKey:@"longitude"] andArea:[a objectForKey:@"area"]];
    
    // create Marker
    Marker *marker = [self createAndAddMarkerToCoreDataWithTitle:[a objectForKey:@"name"] subtitle:[a objectForKey:@"ambience"]andIcon:nil];
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    Animal *animal = [AGCoreDataHelper insertManagedObjectOfClass:[Animal class] inManagedObjectContext:self.context];

    animal.name = [a objectForKey:@"name"];
    animal.relationship = [a objectForKey:@"relationship"];
    animal.category = [a objectForKey:@"category"];
    animal.habitat = [a objectForKey:@"habitat"];
    animal.relationship = [a objectForKey:@"relationship"];
    animal.maximumAge = [a objectForKey:@"maximumAge"];
    animal.size = [a objectForKey:@"size"];
    animal.weight = [a objectForKey:@"weight"];
    animal.socialStructure = [a objectForKey:@"socialStructure"];
    animal.propagation = [a objectForKey:@"propagation"];
    animal.enemies = [a objectForKey:@"enemies"];
    animal.food = [a objectForKey:@"food"];
    animal.threadState = [a objectForKey:@"threadState"];
    animal.funFact = [a objectForKey:@"funFact"];
    animal.image = [a objectForKey:@"image"];
    
    animal.location = location;
    animal.marker = marker;

    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    // get FeedingEvent
    NSString *predString = [NSString stringWithFormat:@"%@Fütterung", animal.name];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"name = %@", predString];
    Event *feedingEvent = [[AGCoreDataHelper fetchEntitiesForClass:[Event class] withPredicate:pred inManagedObjectContext:self.context] objectAtIndex:0];
    if (feedingEvent != nil) {
        [animal addEventObject:feedingEvent];
    }

    // get CommentaryEvent
    predString = [NSString stringWithFormat:@"%@Kommentierung", animal.name];
    pred = [NSPredicate predicateWithFormat:@"name = %@", predString];
    Event *commentaryEvent = [[AGCoreDataHelper fetchEntitiesForClass:[Event class] withPredicate:pred inManagedObjectContext:self.context] objectAtIndex:0];
    if (commentaryEvent != nil) {
        [animal addEventObject:commentaryEvent];
    }
    
    // get Enclosure
    predString = [a objectForKey:@"enclosure"];
    pred = [NSPredicate predicateWithFormat:@"name = %@", predString];
    Enclosure *enclosure = [[AGCoreDataHelper fetchEntitiesForClass:[Enclosure class] withPredicate:pred inManagedObjectContext:self.context] objectAtIndex:0];
    animal.enclosure = enclosure;
    [enclosure addAnimalsObject:animal];
    
    location.zooItem = animal;
    marker.zooItem = animal;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
}

- (void) createAndAddEnclosureToCoreData: (NSDictionary*) a {
    
   // NSLog(@"[AGJSONParser] createAndAddEnclosureToCoreData");

    // create Location
    Location *location = [self createAndAddLocationToCoreDataWithLatitude:[a objectForKey:@"latitude"] longitude:[a objectForKey:@"longitude"] andArea:[a objectForKey:@"area"]];
    
    // create Marker
    Marker *marker = [self createAndAddMarkerToCoreDataWithTitle:[a objectForKey:@"name"] subtitle:[a objectForKey:@"ambience"]andIcon:nil];
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    Enclosure *enclosure = [AGCoreDataHelper insertManagedObjectOfClass:[Enclosure class] inManagedObjectContext:self.context];
    
    enclosure.name = [a objectForKey:@"name"];
    enclosure.additionalInfo = [a objectForKey:@"additionalInfo"];
    
    enclosure.location = location;
    enclosure.marker = marker;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    location.zooItem = enclosure;
    marker.zooItem = enclosure;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    
}

- (void) createAndAddRestaurantToCoreData: (NSDictionary*) a {
    
   // NSLog(@"[AGJSONParser] createAndAddRestaurantToCoreData");

    // create Location
    Location *location = [self createAndAddLocationToCoreDataWithLatitude:[a objectForKey:@"latitude"] longitude:[a objectForKey:@"longitude"] andArea:[a objectForKey:@"area"]];
    
    // create Marker
    Marker *marker = [self createAndAddMarkerToCoreDataWithTitle:[a objectForKey:@"name"] subtitle:[a objectForKey:@"ambience"]andIcon:nil];

    [AGCoreDataHelper saveManagedObjectContext:self.context];

    Restaurant *restaurant = [AGCoreDataHelper insertManagedObjectOfClass:[Restaurant class] inManagedObjectContext:self.context];
    
    restaurant.name = [a objectForKey:@"name"];
    restaurant.catering = [a objectForKey:@"catering"];
    restaurant.seats = [a objectForKey:@"seats"];
    restaurant.openingHours = [a objectForKey:@"openingHours"];
    restaurant.ambience = [a objectForKey:@"ambience"];
    restaurant.food = [a objectForKey:@"food"];
    restaurant.additionalInfo = [a objectForKey:@"additionalInfo"];
    restaurant.bookingPhone = [a objectForKey:@"bookingPhone"];
    restaurant.image = [a objectForKey:@"image"];
    
    restaurant.location = location;
    restaurant.marker = marker;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    location.zooItem = restaurant;
    marker.zooItem = restaurant;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
}

- (void) createAndAddServiceToCoreData: (NSDictionary*) a {
    
   // NSLog(@"[AGJSONParser] createAndAddServiceToCoreData");
    
    // create Location
    Location *location = [self createAndAddLocationToCoreDataWithLatitude:[a objectForKey:@"latitude"] longitude:[a objectForKey:@"longitude"] andArea:[a objectForKey:@"area"]];
    
    // create Marker
    Marker *marker = [self createAndAddMarkerToCoreDataWithTitle:[a objectForKey:@"name"] subtitle:[a objectForKey:@"ambience"]andIcon:nil];

    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    Service *service = [AGCoreDataHelper insertManagedObjectOfClass:[Service class] inManagedObjectContext:self.context];
    
    service.name = [a objectForKey:@"name"];
    service.type = [a objectForKey:@"type"];
    
    service.location = location;
    service.marker = marker;

    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
    location.zooItem = service;
    marker.zooItem = service;
    
    [AGCoreDataHelper saveManagedObjectContext:self.context];
    
}


@end
