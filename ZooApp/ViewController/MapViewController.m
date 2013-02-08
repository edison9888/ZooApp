//
//  MapViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "MapViewController.h"
#import "AGAnimalDetailViewController.h"
#import "AGCoreDataHelper.h"
#import "ZooItem.h"
#import "Location.h"
#import "Restaurant.h"
#import "Enclosure.h"
#import "Service.h"
#import "AGConstants.h"



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
    zoomLocation.latitude = 52.514523;  // increase to move upwards
    zoomLocation.longitude = 13.409650; // increase to move to the right
    
    // region to display
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 450, 750);
    
    // display the region
    [self.iosMapView setRegion:viewRegion animated:YES];
    
    // add annotations
    NSArray *zooItems = [AGCoreDataHelper fetchEntitiesForClass:[ZooItem class] withPredicate:nil inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    
    for (ZooItem *zi in zooItems) {
        [self.iosMapView addAnnotation:zi.location];
    }
    
    [self.iosMapView setShowsUserLocation:YES];


   }

- (void)viewWillAppear:(BOOL)animated {
     


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
    }
    
    if([annotation isKindOfClass:[Location class]]) {
        Location *ann = (Location*) annotation;
        if ([ann.zooItem isKindOfClass:[Animal class]]) {
            pinView.image = [UIImage imageNamed:cAnimalAnnotationIconPath];
        } else if ([ann.zooItem isKindOfClass:[Restaurant class]]) {
            pinView.rightCalloutAccessoryView = rightButton;
            [rightButton addTarget:self action:@selector(showRestaurantDetails:) forControlEvents:UIControlEventTouchUpInside];
            pinView.image = [UIImage imageNamed:cRestaurantAnnotationIconPath];
        } else if ([ann.zooItem isKindOfClass:[Enclosure class]]) {
            pinView.image = [UIImage imageNamed:cEnclosureAnnotationIconPath];
        } else if ([ann.zooItem isKindOfClass:[Service class]]) {
            Service *ser = (Service*) ann.zooItem;
            if ([ser.type isEqualToString:@"WC"]) {
                pinView.image = [UIImage imageNamed:cToiletAnnotationIconPath];
            } else if ([ser.type isEqualToString:@"Giftshop"]) {
                pinView.image = [UIImage imageNamed:cGiftshopAnnotationIconPath];
            } else if ([ser.type isEqualToString:@"Medicare"]) {
                pinView.image = [UIImage imageNamed:cMedicareAnnotationIconPath];
            }
            
        }
    }
    
    UIImage *im = [UIImage imageNamed:cMedicareAnnotationIconPath];
    pinView.centerOffset = CGPointMake(0, -im.size.width / 2);
    

  //  UIImageView *profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Icon-72.png"]];
//    pinView.leftCalloutAccessoryView = profileIconView;
    
    
    return pinView;
}


- (IBAction)showRestaurantDetails:(id)sender {
    
    NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX");
 
    
 //   AnimalDetailViewController * lvc = [[AnimalDetailViewController alloc] init];
    //lvc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    //[lvc setDelegate:self];
    //[self presentModalViewController:lvc animated:YES];
   // [self.navigationController pushViewController:lvc animated:YES];
}

@end
