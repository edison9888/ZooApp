//
//  AGRestaurantViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 07.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGRestaurantMapViewController.h"
#import "Restaurant.h"
#import "Location.h"
#import "AGConstants.h"

@interface AGRestaurantMapViewController ()

@end

@implementation AGRestaurantMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // location to zoom in
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = self.currentRestaurant.location.latitude.doubleValue;  // increase to move upwards
    zoomLocation.longitude = self.currentRestaurant.location.longitude.doubleValue; // increase to move to the right
    
    // region to display
    self.viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
    
    // display the region
    [self.restaurantMapView setRegion:self.viewRegion animated:NO];
    
    // add annotation
    [self.restaurantMapView addAnnotation:self.currentRestaurant.location];

    [self.restaurantMapView setShowsUserLocation:YES];
    
    
}


- (void) viewDidAppear:(BOOL)animated {
    
    [self.restaurantMapView setRegion:self.viewRegion animated:NO];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
    
    MKAnnotationView *pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationIdentifier"];
    
    pinView.canShowCallout = YES;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;  //return nil to use default blue dot view
    } else {
        pinView.image = [UIImage imageNamed:cRestaurantAnnotationIconPath];
    }
    
    UIImage *im = [UIImage imageNamed:cMedicareAnnotationIconPath];
    pinView.centerOffset = CGPointMake(0, -im.size.width / 2);
    
    return pinView;
    
}



@end
