//
//  AnimalDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalDetailViewController.h"
#import "AnimalMapViewController.h"

@interface AnimalDetailViewController ()

@end

@implementation AnimalDetailViewController

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
   
    [self.view setBackgroundColor:Colors.sandColor];
    
    self.navigationItem.title = self.currentAnimal.species;
    self.habitatLabel.text = self.currentAnimal.habitat;
    self.areaLabel.text = self.currentAnimal.area;
    self.categoryLabel.text = self.currentAnimal.category;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setHabitatLabel:nil];
    [self setCategoryLabel:nil];
    [self setAreaLabel:nil];
    [super viewDidUnload];
}


#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showAnimalOnMap"]) {
        AnimalMapViewController *controller = segue.destinationViewController;
        controller.currentAnimal = self.currentAnimal;
        return;
    }
    
}
@end
