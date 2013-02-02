//
//  AGRestaurantDetailViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Restaurant.h"

@interface AGRestaurantDetailViewController : UIViewController <UIScrollViewDelegate, UIPageViewControllerDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *currentLocation;

@property (weak, nonatomic) IBOutlet UIImageView *restaurantImageView;
@property (strong, nonatomic) Restaurant *currentRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *compassImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UIScrollView *chalkboardScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *chalkboardPageControl;

- (IBAction)pageChanged:(UIPageControl *)sender;


@end
