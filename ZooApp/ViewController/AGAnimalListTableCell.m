//
//  AnimalListTableCell.m
//  ZooApp
//
//  Created by Andrea Gerlach on 07.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGAnimalListTableCell.h"

@implementation AGAnimalListTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
