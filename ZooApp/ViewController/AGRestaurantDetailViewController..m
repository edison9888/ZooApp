//
//  AGRestaurantDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGRestaurantDetailViewController.h"
#import "Location.h"

@interface AGRestaurantDetailViewController ()

@end

@implementation AGRestaurantDetailViewController

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
    self.view.backgroundColor = Colors.sandColor;
    self.title = @"Details";
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Zooplan" style:UIBarButtonItemStylePlain target:self action:@selector(showRestaurantOnMap)];
    self.navigationItem.rightBarButtonItem = mapButton;
    
    self.restaurantNameLabel.text = self.currentRestaurant.name;
    
    self.areaLabel.text = [NSString stringWithFormat:@"Themenwelt: %@", self.currentRestaurant.location.area];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
