//
//  AnimalListTableCell.h
//  ZooApp
//
//  Created by Andrea Gerlach on 07.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalListTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *animalName;
@property (weak, nonatomic) IBOutlet UIImageView *animalThumbnail;

@end
