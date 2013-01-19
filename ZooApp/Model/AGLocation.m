//
//  Location.m
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "Location.h"

@implementation Location

- (id) initWithName:(NSString*) name subtitle:(NSString*)subtitle icon:(NSString*)icon color:(UIColor*)color coordinate:(CLLocationCoordinate2D)coordinate {
    if((self = [super init])) {
        self.name = [name copy];
        self.subtitle = [subtitle copy];
        self.icon = [icon copy];
        self.color = [color copy];
        self.coordinate = coordinate;
    }
    return self;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}


- (id)initWithLocation:(CLLocationCoordinate2D)coord {
    self = [super init];
    if (self) {
        self.coordinate = coord;
    }
    return self;
}

@end
