//
//  AGAnimalDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 08.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGAnimalDetailViewController.h"
#import "AGAnimalMapViewController.h"
#import "AGCompassView.h"
#import "AGStringUtilities.h"
#import "AGFavManager.h"
#import "Location.h"
#import "Enclosure.h"
#import "Event.h"
#import "AGCoreDataHelper.h"

@interface AGAnimalDetailViewController ()

@end

@implementation AGAnimalDetailViewController

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
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Zooplan" style:UIBarButtonItemStylePlain target:self action:@selector(showAnimalOnMap)];
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
    AGCompassView *compassView = [[AGCompassView alloc] initWithFrame:CGRectMake(227, 357, compassImage.size.width, compassImage.size.height)];
    compassView.currentZooItem = self.currentAnimal;
    compassView.backgroundColor = [UIColor clearColor];
    [self.mainScrollView addSubview:compassView];
/*
    if ([[AGFavManager sharedInstance] getFavAnimalWithName:self.currentAnimal.name] != nil) {
        self.favAnimal = YES;
    } else {
        self.favAnimal = NO;
    }
    self.favFeedingTime = NO;
    self.favCommentaryTime = NO;
  */   
    [self checkFavStatus];
    [self createChalkboardView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEnclosureLabel:nil];
    [self setAreaLabel:nil];
    [self setDistanceLabel:nil];
    [self setDirectionLabel:nil];
    [self setChalkboardScrollView:nil];
    [self setChalkboardPageControl:nil];
    [self setAnimalImageView:nil];
    [self setAnimalNameLabel:nil];
    [self setFeedingLabel:nil];
    [self setCommentaryLabel:nil];
    [self setFavAnimalButton:nil];
    [self setFavFeedingButton:nil];
    [self setFavCommentaryButton:nil];
    [self setFunFactTextView:nil];
    [self setCompassImageView:nil];
    [self setMainScrollView:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [self updateFields];
    
   /* if ([self.currentAnimal.feedingTime isEqualToString:@"nicht öffentlich"]) {
        self.favFeedingButton.hidden = YES;
    }
    if ([self.currentAnimal.commentaryTime isEqualToString:@"nicht öffentlich"]) {
        self.favCommentaryButton.hidden = YES;
    }
    */
}

- (void)updateFields {
    
    NSString *distance = @"444 m";
    
    self.animalImageView.image = [UIImage imageNamed:self.currentAnimal.image];
    self.animalNameLabel.text = self.currentAnimal.name;
    self.enclosureLabel.text = [NSString stringWithFormat:@"Gehege: %@", self.currentAnimal.enclosure.name];
    self.areaLabel.text = [NSString stringWithFormat:@"Themenwelt: %@", self.currentAnimal.location.area];
    self.distanceLabel.text = distance;
    
    self.feedingLabel.text = @"nicht öffentlich";
    self.commentaryLabel.text = @"nicht öffentlich";
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm"];
    
     NSArray *evs = [self.currentAnimal.event allObjects];
    for (Event* ev in evs) {
        if ([ev.type isEqualToString:@"Fütterung"]) {
            self.feedingLabel.text = [NSString stringWithFormat:@"%@ Uhr", [formatter stringFromDate:ev.time]];
        }
        if ([ev.type isEqualToString:@"Kommentierung"]) {
            self.commentaryLabel.text = [NSString stringWithFormat:@"%@ Uhr", [formatter stringFromDate:ev.time]];
        }
    }

    self.funFactTextView.text = self.currentAnimal.funFact;
    CGRect frame = self.funFactTextView.frame;
    frame.size.height = self.funFactTextView.contentSize.height;
    self.funFactTextView.frame = frame;
    
    
    [self updateDistanceToPoi];
    
}

- (void)createChalkboardView {
    
    NSArray *chalkboardHeading = [[NSArray alloc] initWithObjects:
                                  @"Kategorie",
                                  @"Verwandschaft",
                                  @"Lebensraum",
                                  @"Höchstalter",
                                  @"Größe",
                                  @"Gewicht",
                                  @"Sozialstruktur",
                                  @"Fortpflanzung",
                                  @"Feinde",
                                  @"Nahrung",
                                  @"Bedrohungsstatus",
                                  nil];
    
    NSArray *chalkboardContent = [[NSArray alloc] initWithObjects:
                                  self.currentAnimal.category,
                                  self.currentAnimal.relationship,
                                  self.currentAnimal.habitat,
                                  self.currentAnimal.maximumAge,
                                  self.currentAnimal.size,
                                  self.currentAnimal.weight,
                                  self.currentAnimal.socialStructure,
                                  self.currentAnimal.propagation,
                                  self.currentAnimal.enemies,
                                  self.currentAnimal.food,
                                  self.currentAnimal.threadState,
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
 

- (IBAction)pageChanged:(id)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.chalkboardScrollView.frame.size.width * self.chalkboardPageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.chalkboardScrollView.frame.size;
    [self.chalkboardScrollView scrollRectToVisible:frame animated:YES];
}

#pragma mark - favorites and alerts

- (void)checkFavStatus {
    
    if (self.favAnimal == NO) {
        [self.favAnimalButton setImage:[UIImage imageNamed:@"whiteStarFav.png"] forState:UIControlStateNormal];
    } else {
        [self.favAnimalButton setImage:[UIImage imageNamed:@"goldStarFav.png"] forState:UIControlStateNormal];
    }
    
    if (self.favFeedingTime == NO) {
        [self.favFeedingButton setImage:[UIImage imageNamed:@"whiteStarFav.png"] forState:UIControlStateNormal];
    } else {
        [self.favFeedingButton setImage:[UIImage imageNamed:@"goldStarFav.png"] forState:UIControlStateNormal];
    }
    
    if (self.favCommentaryTime == NO) {
        [self.favCommentaryButton setImage:[UIImage imageNamed:@"whiteStarFav.png"] forState:UIControlStateNormal];
    } else {
        [self.favCommentaryButton setImage:[UIImage imageNamed:@"goldStarFav.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)favAnimalButtonPressed:(id)sender {
    [self createFavAlertViewWithArticle:@"das" object:@"Tier" fav:self.favAnimal];
}

- (IBAction)favFeedingButtonPressed:(id)sender {
    [self createFavAlertViewWithArticle:@"die" object:@"Fütterung" fav:self.favFeedingTime];
}

- (IBAction)favCommentaryButtonPressed:(id)sender {
    [self createFavAlertViewWithArticle:@"die" object:@"Kommentierung" fav:self.favCommentaryTime];
}

- (void)createFavAlertViewWithArticle:(NSString*)article object:(NSString*)object fav:(BOOL) fav{

    NSString *titleString;
    NSString *messageString;
    NSString *messageEnding = @"Diese können Sie unter der Rubrik \"Mein Zoo\" einsehen.";

    
    if (fav) {
        titleString = [NSString stringWithFormat:@"%@ entfernen", object];
        messageString = [NSString stringWithFormat:@"Hiermit entfernen Sie %@ %@ aus Ihrer Favoritenliste. %@", article, object, messageEnding];
    } else {
        titleString = [NSString stringWithFormat:@"%@ favorisieren", object];
        messageString = [NSString stringWithFormat:@"Hiermit fügen Sie %@ %@ Ihrer Favoritenliste hinzu. %@", article, object, messageEnding];
    }

    UIAlertView *alert;
    alert = [[UIAlertView alloc] initWithTitle:titleString message:messageString delegate:self cancelButtonTitle:@"Abbrechen" otherButtonTitles:@"Ok", nil];
    
    [alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if([[alertView buttonTitleAtIndex:buttonIndex] isEqualToString:@"Ok"]) {
       
        if ([[alertView title] isEqualToString:@"Tier favorisieren"]) {
           
            self.favAnimal = YES;
            // add animal to favorites
            [[AGFavManager sharedInstance] addAnimalToFavsWithName:self.currentAnimal.name notified:NO];
        
        } else if ([[alertView title] isEqualToString:@"Tier entfernen"]) {
            
            self.favAnimal = NO;
            // remove animal from favorites
            [[AGFavManager sharedInstance] removeAnimalFromFavsWithName:self.currentAnimal.name];
            
        } else  if ([[alertView title] isEqualToString:@"Fütterung favorisieren"]) {
            self.favFeedingTime = YES;
            // methode zum hinzufügen
            NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Fütterung hinzufügen");
        
        } else if ([[alertView title] isEqualToString:@"Fütterung entfernen"]) {
            self.favFeedingTime = NO;
            // methode zum entfernen
            NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Fütterung entfernen");
       
        } else if ([[alertView title] isEqualToString:@"Kommentierung favorisieren"]) {
            self.favCommentaryTime = YES;
            // methode zum hinzufügen
            NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Kommentierung hinzufügen");
  
        } else if ([[alertView title] isEqualToString:@"Kommentierung entfernen"]) {
            self.favCommentaryTime = NO;
            // methode zum entfernen
            NSLog(@"XXXXXXXX Hier bin ich XXXXXXXX Kommentierung entfernen");
        }
    }
    [self checkFavStatus];
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
                               initWithLatitude:self.currentAnimal.location.latitude.doubleValue
                               longitude:self.currentAnimal.location.longitude.doubleValue];
    
    CLLocation *userLocation = [[CLLocation alloc]
                                initWithLatitude:self.currentLocation.coordinate.latitude
                                longitude:self.currentLocation.coordinate.longitude];
    
    CLLocationDistance distance = [poiLocation distanceFromLocation:userLocation];
    
    self.distanceLabel.text = [AGStringUtilities localizedDistanceFromMeters:distance];
}

- (void)showAnimalOnMap {
    AGAnimalMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGAnimalMapViewController"];
    vc.currentAnimal = self.currentAnimal;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
