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

- (void)setAnnotationForLocationWithTitle:(NSString*)title subtitle:(NSString*)subtitle icon:(NSString*)icon {
    
    self.title = title;
    self.subtitle = subtitle;
    self.icon = icon;
}

- (NSString *)title {
    if ([_title isKindOfClass:[NSNull class]])
        return @"Unknown charge";
    else
        return _title;
}




@end
