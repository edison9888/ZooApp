//
//  AnimalDetailViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"

@interface AnimalDetailViewController : UIViewController

@property (strong, nonatomic) Animal *currentAnimal;
@property (weak, nonatomic) IBOutlet UILabel *habitatLabel;


@end
