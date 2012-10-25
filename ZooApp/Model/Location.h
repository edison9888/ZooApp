//
//  Location.h
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Location : NSObject <MKAnnotation>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CLLocationCoordinate2D coordinate;

- (id)initWithName:(NSString*)name subtitle:(NSString*)subtitle icon:(NSString*)icon color:(UIColor*)color coordinate:(CLLocationCoordinate2D)coordinate;
- (id)initWithLocation:(CLLocationCoordinate2D)coord;

@end
