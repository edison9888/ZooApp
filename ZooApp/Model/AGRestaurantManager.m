//
//  AGRestaurantManager.m
//  ZooApp
//
//  Created by Andrea Gerlach on 19.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGRestaurantManager.h"
#import "AGRestaurant.h"
#import "AGLocation.h"

@implementation AGRestaurantManager

static AGRestaurantManager *instance = nil;

- (id)init
{
    self = [super init];
    if (self) {
        [self parseJSONToRestaurants];
    }
    return self;
}

+(AGRestaurantManager*)getInstance {
    
    @synchronized(self) {
        if (instance == nil) {
            instance = [AGRestaurantManager new];
        }
    }
    return instance;
}


#pragma mark - init methods

- (void)parseJSONToRestaurants {
    
    NSLog(@"Restaurants are being parsed from JSON");
    
    NSString *pathToRestaurantList = [[NSBundle mainBundle] pathForResource:@"restaurantList" ofType:@"json"];
    NSData *restaurantListData = [NSData dataWithContentsOfFile:pathToRestaurantList];
    NSError *error;
    NSDictionary *restaurantListJSON = [NSJSONSerialization JSONObjectWithData:restaurantListData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Fehler: %@", [error localizedDescription]);
    }
    
    NSArray *restaurantArrayJSON = [restaurantListJSON objectForKey:@"restaurants"];
    
    self.allRestaurants = [NSMutableArray new];
    
    for (NSDictionary *a in restaurantArrayJSON) {
        
        AGRestaurant *restaurant = [AGRestaurant new];
        
        restaurant.name = [a objectForKey:@"name"];
        restaurant.latitude = [a objectForKey:@"latitude"];
        restaurant.longitude = [a objectForKey:@"longitude"];
        
        CLLocationCoordinate2D restaurantCoordinate;
        restaurantCoordinate.latitude = [[a objectForKey:@"latitude"] doubleValue];
        restaurantCoordinate.longitude = [[a objectForKey:@"longitude"] doubleValue];
        AGLocation *location = [[AGLocation alloc] initLocationWithCoordinate:restaurantCoordinate];
        
        restaurant.location = location;
        restaurant.area = [a objectForKey:@"area"];
        restaurant.catering = [a objectForKey:@"catering"];
        restaurant.seats = [a objectForKey:@"seats"];
        restaurant.openingHours = [a objectForKey:@"openingHours"];
        restaurant.ambience = [a objectForKey:@"ambience"];
        restaurant.food = [a objectForKey:@"food"];
        restaurant.additionalInfo = [a objectForKey:@"additionalInfo"];
        restaurant.bookingPhone = [a objectForKey:@"bookingPhone"];
        restaurant.image = [a objectForKey:@"image"];
                
        [restaurant.location setAnnotationForLocationWithName:restaurant.name subtitle:restaurant.ambience image:restaurant.image color:MKPinAnnotationColorPurple];
        
        [self.allRestaurants addObject:restaurant];
        
    }
    
}

@end
