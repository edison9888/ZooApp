//
//  AnimalFilterViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 24.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGAnimalFilterViewController.h"
#import "AnimalFilterTableCell.h"
#import "AGAnimalListViewController.h"
#import "AGAnimalManager.h"
#import "AGConstants.h"

@interface AGAnimalFilterViewController ()



@end

@implementation AGAnimalFilterViewController

   
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    // Custom initialization
        

    }
    return self;
}
   
- (void)viewDidLoad {
   
   [super viewDidLoad];
   // Do any additional setup after loading the view.
   
   [self.view setBackgroundColor:Colors.sandColor];
    
    self.barButtonItemDone = [[UIBarButtonItem alloc] initWithTitle:@"Fertig" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonItemDonePressed:)];
    self.navigationItem.rightBarButtonItem = self.barButtonItemDone;
       
    self.title = @"Tier-Filter";
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [self unselectAllCatButtons];
    [self unselectAllAreaButtons];
    [self useAppropriateCatFiler];
    [self useAppropriateAreaFiler];
}
    

- (void) useAppropriateCatFiler {
    if ([self.catFilterString isEqualToString:cCatFilterMammals]) {
        self.mammalsButton.selected = YES;
    } else if ([self.catFilterString isEqualToString:cCatFilterBirds]){
        self.birdsButton.selected = YES;
    } else if ([self.catFilterString isEqualToString:cCatFilterReptiles]){
        self.reptilesButton.selected = YES;
    } else if ([self.catFilterString isEqualToString:cCatFilterAmphibians]){
        self.amphibiansButton.selected = YES;
    } else if ([self.catFilterString isEqualToString:cCatFilterInvertebrates]){
        self.invertebratesButton.selected = YES;
    } else if ([self.catFilterString isEqualToString:cCatFilterFish]){
        self.fishButton.selected = YES;
    }
}

- (void) useAppropriateAreaFiler {
    if ([self.areaFilterString isEqualToString:cAreaFilterFoundersGarden]) {
        self.foundersGardenButton.selected = YES;
    } else if ([self.areaFilterString isEqualToString:cAreaFilterGondwanaland]){
        self.gondwanaland.selected = YES;
    } else if ([self.areaFilterString isEqualToString:cAreaFilterAsia]){
        self.asiaButton.selected = YES;
    } else if ([self.areaFilterString isEqualToString:cAreaFilterPongoland]){
        self.pongolandButton.selected = YES;
    } else if ([self.areaFilterString isEqualToString:cAreaFilterAfrica]){
        self.africaButton.selected = YES;
    } else if ([self.areaFilterString isEqualToString:cAreaFilterSouthAmerica]){
        self.southAmericaButton.selected = YES;
    }
}

- (void) unselectAllCatButtons {
    
    self.mammalsButton.selected = NO;
    self.birdsButton.selected = NO;
    self.reptilesButton.selected = NO;
    self.amphibiansButton.selected = NO;
    self.invertebratesButton.selected = NO;
    self.fishButton.selected = NO;
}

- (void) unselectAllAreaButtons {
    
    self.foundersGardenButton.selected = NO;
    self.gondwanaland.selected = NO;
    self.asiaButton.selected = NO;
    self.pongolandButton.selected = NO;
    self.asiaButton.selected = NO;
    self.southAmericaButton.selected = NO;
}

- (void) barButtonItemDonePressed: (id) sender {
    [self.delegate setCatFilterString:self.catFilterString];
    [self.delegate setAreaFilterString:self.areaFilterString];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    
   [super didReceiveMemoryWarning];
   // Dispose of any resources that can be recreated.
}
   
- (IBAction)filterButtonPressed:(id)sender {
   
   
   UIButton *button = (UIButton*) sender;
   
   switch (button.tag) {
       case 0:
           
           [self unselectAllCatButtons];
           [self unselectAllAreaButtons];
           self.catFilterString = nil;
           self.areaFilterString = nil;
           break;
       case 1:
           if (!button.selected) {
               [self unselectAllCatButtons];
               self.mammalsButton.selected = YES;
               self.catFilterString = cCatFilterMammals;
           } else {
               [self unselectAllCatButtons];
               self.catFilterString = nil;
           }
           break;
       case 2:
           if (!button.selected) {
               [self unselectAllCatButtons];
               self.birdsButton.selected = YES;
               self.catFilterString = cCatFilterBirds;
           } else {
               [self unselectAllCatButtons];
               self.catFilterString = nil;
           }
           break;
       case 3:
           if (!button.selected) {
               [self unselectAllCatButtons];
               self.reptilesButton.selected = YES;
               self.catFilterString = cCatFilterReptiles;
           } else {
               [self unselectAllCatButtons];
               self.catFilterString = nil;
           }
           break;
       case 4:
           if (!button.selected) {
               [self unselectAllCatButtons];
               self.amphibiansButton.selected = YES;
               self.catFilterString = cCatFilterAmphibians;
           } else {
               [self unselectAllCatButtons];
               self.catFilterString = nil;
           }
           break;
       case 5:
           if (!button.selected) {
               [self unselectAllCatButtons];
               self.invertebratesButton.selected = YES;
               self.catFilterString = cCatFilterInvertebrates;
           } else {
               [self unselectAllCatButtons];
               self.catFilterString = nil;
           }
           break;
       case 6:
           if (!button.selected) {
               [self unselectAllCatButtons];
               self.fishButton.selected = YES;
               self.catFilterString = cCatFilterFish;
           } else {
               [self unselectAllCatButtons];
               self.catFilterString = nil;
           }
           break;
       case 7:
           if (!button.selected) {
               [self unselectAllAreaButtons];
               self.foundersGardenButton.selected = YES;
               self.areaFilterString = cAreaFilterFoundersGarden;
           } else {
               [self unselectAllAreaButtons];
               self.areaFilterString = nil;
           }
           break;
       case 8:
           if (!button.selected) {
               [self unselectAllAreaButtons];
               self.gondwanaland.selected = YES;
               self.areaFilterString = cAreaFilterGondwanaland;
           } else {
               [self unselectAllAreaButtons];
               self.areaFilterString = nil;
           }
           break;
       case 9:
           if (!button.selected) {
               [self unselectAllAreaButtons];
               self.asiaButton.selected = YES;
               self.areaFilterString = cAreaFilterAsia;
           } else {
               [self unselectAllAreaButtons];
               self.areaFilterString = nil;
           }
           break;
       case 10:
           if (!button.selected) {
               [self unselectAllAreaButtons];
               self.pongolandButton.selected = YES;
               self.areaFilterString = cAreaFilterPongoland;
           } else {
               [self unselectAllAreaButtons];
               self.areaFilterString = nil;
           }
           break;
       case 11:
           if (!button.selected) {
               [self unselectAllAreaButtons];
               self.africaButton.selected = YES;
               self.areaFilterString = cAreaFilterAfrica;
           } else {
               [self unselectAllAreaButtons];
               self.areaFilterString = nil;
           }
           break;

       case 12:
           if (!button.selected) {
               [self unselectAllAreaButtons];
               self.southAmericaButton.selected = YES;
               self.areaFilterString = cAreaFilterSouthAmerica;
           } else {
               [self unselectAllAreaButtons];
               self.areaFilterString = nil;
           }
           break;
       default:
           break;
   }
}
   
   
@end
