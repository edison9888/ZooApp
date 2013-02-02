//
//  AGInfoEntryViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 28.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGInfoEntryViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
