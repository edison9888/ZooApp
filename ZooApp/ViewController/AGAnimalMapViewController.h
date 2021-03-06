//
//  AGAnimalMapViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 22.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Animal.h"

@interface AGAnimalMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) Animal *currentAnimal;
@property (weak, nonatomic) IBOutlet MKMapView *animalMapView;
@property (assign) MKCoordinateRegion viewRegion;

@end
