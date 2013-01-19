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

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *image;
@property (assign) MKPinAnnotationColor pinColor;

- (id)initLocationWithCoordinate:(CLLocationCoordinate2D)coord;

- (void)setAnnotationForLocationWithName:(NSString*)name subtitle:(NSString*)subtitle image:(NSString*)image color:(MKPinAnnotationColor)pinColor;


@end
