//
//  AGRestaurantDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGRestaurantDetailViewController.h"
#import "AGRestaurantMapViewController.h"
#import "Location.h"
#import "AGStringUtilities.h"
#import "AGCompassView.h"

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
    
    
    // LOCATION
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.distanceFilter = 10.0;
    self.locationManager.delegate=self;
    [self.locationManager startUpdatingLocation];
    
    
    // COMPASS
    self.compassImageView.hidden = YES;
    UIImage *compassImage = [UIImage imageNamed:@"details_compass.png"];
    AGCompassView *compassView = [[AGCompassView alloc] initWithFrame:CGRectMake(227, 327, compassImage.size.width, compassImage.size.height)];
    compassView.currentZooItem = self.currentRestaurant;
    compassView.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:compassView];
    
    [self createChalkboardView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateFields];
}

- (void)updateFields {
    
    NSString *distance = @"444 m";
    
    self.restaurantImageView.image = [UIImage imageNamed:self.currentRestaurant.image];
    self.restaurantNameLabel.text = self.currentRestaurant.name;
    self.areaLabel.text = [NSString stringWithFormat:@"Themenwelt: %@", self.currentRestaurant.location.area];
    self.distanceLabel.text = distance;
       
    [self updateDistanceToPoi];
    
}

- (void)createChalkboardView {
    
    NSArray *chalkboardHeading = [[NSArray alloc] initWithObjects:
                                  @"Catering",
                                  @"Plätze",
                                  @"Öffnungszeiten",
                                  @"Ambiente",
                                  @"Sonstiges",
                                  @"Buchung",
                                  nil];
    
    NSArray *chalkboardContent = [[NSArray alloc] initWithObjects:
                                  self.currentRestaurant.catering,
                                  self.currentRestaurant.seats,
                                  self.currentRestaurant.openingHours,
                                  self.currentRestaurant.ambience,
                                  self.currentRestaurant.additionalInfo,
                                  self.currentRestaurant.bookingPhone,
                                  nil];
    
    
    CGRect contentFrame = CGRectMake(0, 0, 230, 180);
    contentFrame.origin.y = 0;
    self.chalkboardScrollView.frame = contentFrame;
    
    for (int i = 0; i < chalkboardContent.count; i++) {
        
        contentFrame.origin.x = self.chalkboardScrollView.frame.size.width * i;
        
        UIView *contentView = [[UIView alloc] initWithFrame:contentFrame];
        //contentView.backgroundColor = [UIColor orangeColor];
        
        UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 210, 28)];
        heading.text = [chalkboardHeading objectAtIndex:i];
        heading.font = [UIFont boldSystemFontOfSize:16];
        heading.textColor = [UIColor whiteColor];
        heading.backgroundColor = [UIColor clearColor];
        [contentView addSubview:heading];
        
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, 210, 152)];
        content.text = [chalkboardContent objectAtIndex:i];
        content.textColor = [UIColor whiteColor];
        content.lineBreakMode = NSLineBreakByWordWrapping;
        content.numberOfLines = 0;
        content.backgroundColor = [UIColor clearColor];
        [content sizeToFit];
        [contentView addSubview:content];
        
        [self.chalkboardScrollView addSubview:contentView];
        
  
    }
    
    self.chalkboardScrollView.contentSize = CGSizeMake(self.chalkboardScrollView.frame.size.width * chalkboardContent.count, self.chalkboardScrollView.frame.size.height);
    self.chalkboardPageControl.numberOfPages = chalkboardContent.count;
    
}



- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.chalkboardScrollView.frame.size.width;
    int page = floor((self.chalkboardScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.chalkboardPageControl.currentPage = page;
    
}


- (IBAction)pageChanged:(UIPageControl *)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.chalkboardScrollView.frame.size.width * self.chalkboardPageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.chalkboardScrollView.frame.size;
    [self.chalkboardScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - location

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //  NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX didUpdateToLocation %@", newLocation);
    
    self.currentLocation = newLocation;
    [self updateDistanceToPoi];
}

-(void)updateDistanceToPoi {
    
    if (self.currentLocation == nil) {
        self.distanceLabel.text = @"n/a";
        return;
    }
    
    CLLocation *poiLocation = [[CLLocation alloc]
                               initWithLatitude:self.currentRestaurant.location.latitude.doubleValue
                               longitude:self.currentRestaurant.location.longitude.doubleValue];
    
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:self.currentLocation.coordinate.latitude
                                longitude:self.currentLocation.coordinate.longitude];
    
    CLLocationDistance distance = [poiLocation distanceFromLocation:userLocation];
    
    self.distanceLabel.text = [AGStringUtilities localizedDistanceFromMeters:distance];

}

- (void)showRestaurantOnMap {
    
    AGRestaurantMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGRestaurantMapViewController"];
    vc.currentRestaurant = self.currentRestaurant;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
