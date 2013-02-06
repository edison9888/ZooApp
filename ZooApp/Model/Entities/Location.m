//
//  Location.m
//  ZooApp
//
//  Created by Andrea Gerlach on 06.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "Location.h"
#import "ZooItem.h"


@implementation Location

@dynamic area;
@dynamic latitude;
@dynamic longitude;
@dynamic title;
@dynamic subtitle;
@dynamic icon;
@dynamic zooItem;


- (void)setAnnotationForLocationWithTitle:(NSString*)title subtitle:(NSString*)subtitle icon:(NSString*)icon {
    
    self.title = title;
    self.subtitle = subtitle;
    self.icon = icon;
}

- (CLLocationCoordinate2D) coordinate {
    CLLocationCoordinate2D coord;
    coord.latitude = self.latitude.doubleValue;
    coord.longitude = self.longitude.doubleValue;
    return coord;
}


@end
