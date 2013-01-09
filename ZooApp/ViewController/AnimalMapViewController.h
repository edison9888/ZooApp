//
//  AnimalMapViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 22.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AGAnimal.h"

@interface AnimalMapViewController : UIViewController

@property (strong, nonatomic) AGAnimal *currentAnimal;
@property (weak, nonatomic) IBOutlet MKMapView *animalMapView;

@end
