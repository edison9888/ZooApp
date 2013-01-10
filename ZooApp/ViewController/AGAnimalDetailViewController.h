//
//  AGAnimalDetailViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 08.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGAnimal.h"

@interface AGAnimalDetailViewController : UIViewController <UIScrollViewDelegate, UIPageViewControllerDelegate>

// UI
@property (weak, nonatomic) IBOutlet UILabel *enclosureLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *chalkboardScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *chalkboardPageControl;


// MODEL
@property (nonatomic, strong) AGAnimal *currentAnimal;

- (IBAction)pageChanged:(id)sender;

@end
