//
//  AGRestaurantListTableCell.h
//  ZooApp
//
//  Created by Andrea Gerlach on 02.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGRestaurantListTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *restaurantName;
@property (weak, nonatomic) IBOutlet UILabel *subtitle;
@property (weak, nonatomic) IBOutlet UIImageView *restaurantThumbnail;

@end
