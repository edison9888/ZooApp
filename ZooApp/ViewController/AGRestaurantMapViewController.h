//
//  AGRestaurantViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 07.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"

@interface AGRestaurantMapViewController : UIViewController <MKMapViewDelegate>

@property (strong, nonatomic) Restaurant *currentRestaurant;
@property (weak, nonatomic) IBOutlet MKMapView *restaurantMapView;
@property (assign) MKCoordinateRegion viewRegion;


@end
