//
//  AGInfoListViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 14.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGInfoListViewController : UITableViewController

@property (strong, nonatomic) NSArray *keyArray;
@property (strong, nonatomic) NSArray *htmlArray;
@property (strong, nonatomic) NSMutableDictionary *infoData;


@end
