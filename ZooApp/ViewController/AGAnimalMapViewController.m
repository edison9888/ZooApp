//
//  AGAnimalMapViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 22.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGAnimalMapViewController.h"
#import "Location.h"
#import "AGConstants.h"

@implementation AGAnimalMapViewController


- (void) viewDidLoad {
    
    [super viewDidLoad];
    
    // location to zoom in
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentAnimal.location.latitude.doubleValue;  // increase to move upwards
    zoomLocation.longitude = self.currentAnimal.location.longitude.doubleValue; // increase to move to the right
    
    
    // region to display
    self.viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
    
    // display the region
    
    [self.animalMapView setRegion:self.viewRegion animated:NO];

    
    
    // add annotation
    [self.animalMapView addAnnotation:self.currentAnimal.location];
    
    [self.animalMapView setShowsUserLocation:YES];
    
    
    

}

- (void) viewDidAppear:(BOOL)animated {

    [self.animalMapView setRegion:self.viewRegion animated:NO];
}


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKAnnotationView *pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationIdentifier"];
    
    pinView.canShowCallout = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;  //return nil to use default blue dot view
    } else {
        pinView.image = [UIImage imageNamed:cAnimalAnnotationIconPath];
    }
    
    UIImage *im = [UIImage imageNamed:cMedicareAnnotationIconPath];
    pinView.centerOffset = CGPointMake(0, -im.size.width / 2);
    
    return pinView;
    
}



@end
