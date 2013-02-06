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
   
   
   self.catFilter = [NSMutableArray new];
   self.areaFilter = [NSMutableArray new];
       
       self.barButtonItemDone = [[UIBarButtonItem alloc] initWithTitle:@"Fertig" style:UIBarButtonItemStyleDone target:self action:@selector(barButtonItemDonePressed:)];
       self.navigationItem.rightBarButtonItem = self.barButtonItemDone;
       
       self.title = @"Tier-Filter";
    
   }
   
   
- (void) barButtonItemDonePressed: (id) sender {
    [self.delegate setCatFilter:self.catFilter];
    [self.delegate setAreaFilter:self.areaFilter];
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
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[UIButton class]]) {
                    UIButton *button = (UIButton*) view;
                    button.selected = NO;
                }
            }
           [self.catFilter removeAllObjects];
           [self.areaFilter removeAllObjects];
           break;
       case 1:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cCatFilterMammals];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cCatFilterMammals];
           }
           break;
       case 2:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cCatFilterBirds];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cCatFilterBirds];
           }
           break;
       case 3:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cCatFilterReptiles];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cCatFilterReptiles];
           }
           break;
       case 4:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cCatFilterAmphibians];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cCatFilterAmphibians];
           }
           break;
       case 5:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cCatFilterInvertebrates];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cCatFilterInvertebrates];
           }
           break;
       case 6:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cCatFilterFish];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cCatFilterFish];
           }
           break;
       case 7:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cAreaFilterFoundersGarden];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cAreaFilterFoundersGarden];
           }
           break;
       case 8:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cAreaFilterGondwanaland];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cAreaFilterGondwanaland];
           }
           break;
       case 9:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cAreaFilterAsia];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cAreaFilterAsia];
           }
           break;
       case 10:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cAreaFilterPongoland];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cAreaFilterPongoland];
           }
           break;
       case 11:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cAreaFilterAfrica];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cAreaFilterAfrica];
           }
           break;
       case 12:
           if (!button.selected) {
               button.selected = YES;
               [self.catFilter addObject:cAreaFilterSouthAmerica];
           } else {
               button.selected = NO;
               [self.catFilter removeObject:cAreaFilterSouthAmerica];
           }
           break;
       default:
           break;
   }

}
   
   
@end
