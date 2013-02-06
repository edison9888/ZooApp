//
//  AGAnimalMapViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 22.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGAnimalMapViewController.h"
#import "Location.h"
#import "Marker.h"
#import "AGLocation.h"

@implementation AGAnimalMapViewController


- (void) viewDidLoad {
    
    // location to zoom in
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentAnimal.location.latitude.doubleValue;  // increase to move upwards
    zoomLocation.longitude = self.currentAnimal.location.longitude.doubleValue; // increase to move to the right
    
    // region to display
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
    
    // display the region
    [self.animalMapView setRegion:viewRegion animated:YES];
    
    // add annotations
    AGLocation *ann = [[AGLocation alloc] initLocationWithCoordinate:zoomLocation];
    
    [ann setAnnotationForLocationWithTitle:self.currentAnimal.marker.title subtitle:self.currentAnimal.marker.subtitle icon:self.currentAnimal.marker.icon];
    [self.animalMapView addAnnotation:ann];
    

}




@end
