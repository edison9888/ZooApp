//
//  MapViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "MapViewController.h"
#import "MarkerManager.h"
#import "AnimalDetailViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

    NSLog(@"MapViewController loaded");
    
    // location to zoom in
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 52.516000;  // increase to move upwards
    zoomLocation.longitude = 13.406000; // increase to move to the right
    
    // region to display
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
    
    // display the region
    [self.iosMapView setRegion:viewRegion animated:YES];
    
    // add annotations
    NSArray *animalMarkers = [MarkerManager createAllAnimalMarkers];
    NSLog(@"Zahl der animalMarkers %d", animalMarkers.count);
    [self.iosMapView addAnnotations:animalMarkers];
    NSMutableArray* annotations=[[NSMutableArray alloc] init];
	[annotations addObjectsFromArray:animalMarkers];
    
   //[self.iosMapView setShowsUserLocation:YES];


   }

- (void)viewWillAppear:(BOOL)animated {
     


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation {
 
    MKPinAnnotationView *pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"AnnotationIdentifier"];
    
    pinView.animatesDrop = YES;
    pinView.canShowCallout = YES;
    pinView.pinColor = MKPinAnnotationColorPurple;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(showDetails:) forControlEvents:UIControlEventTouchUpInside];
    pinView.rightCalloutAccessoryView = rightButton;
    
    UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-72.png"]];
    pinView.leftCalloutAccessoryView = profileIconView;
    
    
    return pinView;

}

- (IBAction)showDetails:(id)sender {
 
    NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX");
    
 //   AnimalDetailViewController * lvc = [[AnimalDetailViewController alloc] init];
    //lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[lvc setDelegate:self];
    //[self presentModalViewController:lvc animated:YES];
   // [self.navigationController pushViewController:lvc animated:YES];
}

@end
