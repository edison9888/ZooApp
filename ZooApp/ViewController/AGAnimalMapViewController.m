//
//  AGAnimalMapViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 22.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGAnimalMapViewController.h"
#import "Location.h"
#import "MarkerManager.h"

@implementation AGAnimalMapViewController

- (void)viewDidUnload {
    [self setAnimalMapView:nil];
    [super viewDidUnload];
}

- (void) viewDidLoad {
    
    // location to zoom in
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentAnimal.latitude.doubleValue;  // increase to move upwards
    zoomLocation.longitude = self.currentAnimal.longitude.doubleValue; // increase to move to the right
    
    // region to display
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
    
    // display the region
    [self.animalMapView setRegion:viewRegion animated:YES];
    
    // add annotations
    
    
    
    Location *animalMarker = [MarkerManager createMarkerForAnimal:self.currentAnimal];
    [self.animalMapView addAnnotation:animalMarker];
    

}




@end
