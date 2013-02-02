//
//  AGRestaurantDetailViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Restaurant.h"

@interface AGRestaurantDetailViewController : UIViewController

@property (strong, nonatomic) Restaurant *currentRestaurant;
@property (weak, nonatomic) IBOutlet UILabel *restaurantNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
