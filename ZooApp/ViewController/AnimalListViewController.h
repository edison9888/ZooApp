//
//  AnimalListViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimalListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *animalListTableView;
@property (nonatomic, strong) NSArray *alphabetArray;
@property (strong, nonatomic) NSArray *indexArray;
@property (strong, nonatomic) NSMutableDictionary *animalsData;


@end
