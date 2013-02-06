//
//  Location.h
//  ZooApp
//
//  Created by Andrea Gerlach on 19.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface AGLocation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *icon;

- (id)initLocationWithCoordinate:(CLLocationCoordinate2D)coord;

- (void)setAnnotationForLocationWithTitle:(NSString*)title subtitle:(NSString*)subtitle icon:(NSString*)icon;


@end
