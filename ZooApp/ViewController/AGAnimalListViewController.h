//
//  AnimalListViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "NSString+Sorting.h"

@class Animal;

@interface AGAnimalListViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) UIBarButtonItem *barButtonItemSearch;
@property (nonatomic, strong) UIBarButtonItem *barButtonItemFilter;
@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic, strong) NSPredicate *basePredicate;
@property (nonatomic, strong) NSPredicate *fetchPredicate;
@property (nonatomic, strong) Animal *animal;

@property (weak, nonatomic) IBOutlet UITableView *animalListTableView;
@property (strong, nonatomic) NSArray *currentFilteredList;


- (NSFetchedResultsController *) fetchedResultsController;


+ (void)setFilterKey: (NSString*) filKey;

@end



