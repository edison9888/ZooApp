//
//  AnimalDetailViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"

@interface AnimalDetailViewController : UIViewController <UIScrollViewDelegate>


@property (strong, nonatomic) IBOutlet UIScrollView *detailAnimalScrollView;
@property (strong, nonatomic) Animal *currentAnimal;

@end
