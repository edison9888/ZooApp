//
//  MapViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "MapViewController.h"
#import "MarkerManager.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    NSLog(@"MapViewController loaded");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
 
    NSLog(@"MapViewController appeared");
    
    // location to zoom in
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = 52.516000;  // increase to move upwards
    zoomLocation.longitude = 13.406000; // increase to move to the right
    
    // region to display
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
  
    // display the region
    [self.iosMapView setRegion:viewRegion animated:YES];
    

    NSArray *animalMarkers = [MarkerManager createAllAnimalMarkers];
    NSLog(@"zahl der animalMarkers %d", animalMarkers.count);
    [self.iosMapView addAnnotations:animalMarkers];
    
    
}

@end
