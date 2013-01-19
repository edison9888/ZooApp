//
//  Location.m
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGLocation.h"

@implementation AGLocation


- (id)initLocationWithCoordinate:(CLLocationCoordinate2D)coord {
    
    self = [super init];
    if (self) {
        self.coordinate = coord;
    }
    return self;
}

- (void)setAnnotationForLocationWithName:(NSString*)name subtitle:(NSString*)subtitle image:(NSString*)image color:(MKPinAnnotationColor)pinColor {
    
    self.name = name;
    self.subtitle = subtitle;
    self.image = image;    
    self.pinColor = pinColor;
}

- (NSString *)title {
    if ([_name isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _name;
}




@end
