//
//  AnimalFilterViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 24.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalFilterViewController : UITableViewController
<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *filterCategories;

@end
