//
//  AnimalListViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AGAnimalListViewController.h"
#import "AGAnimalDetailViewController.h"
#import "AGAnimal.h"
#import "Animal.h"
#import "AGAnimalManager.h"
#import "AGAnimalListTableCell.h"
#import "AGCoreDataHelper.h"
#import "AGStringUtilities.h"
#import "AGAnimalFilterViewController.h"
#import "AGConstants.h"



@interface AGAnimalListViewController ()
@property (nonatomic, strong) NSFetchedResultsController *animalsFetchedResultsController;

@end

static NSString *filterKey;

@implementation AGAnimalListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.barButtonItemSearch = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(barButtonItemSearchPressed:)];
    self.barButtonItemFilter = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonItemFilterPressed:)];
    // RightBarButtomItems
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
                                            self.barButtonItemFilter, self.barButtonItemSearch, nil];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];


    // SearchBar
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.barStyle = UIBarStyleBlackTranslucent;
    self.searchBar.showsCancelButton = NO;
    
    [self.view setBackgroundColor:Colors.sandColor];
    [self.tableView setSeparatorColor:Colors.woodColor];
    [AGCoreDataHelper performFetchOnFetchedResultsController:self.fetchedResultsController];
    
    self.basePredicate = nil;
    self.fetchPredicate = self.basePredicate;
    filterKey = @"Alle Tiere";
 
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSMutableArray *predicates = [NSMutableArray array];
    
    if (self.catFilterString == nil && self.areaFilterString == nil) {
        self.fetchPredicate = nil;
    } else {
        if (self.catFilterString != nil) {
            [predicates addObject:[NSPredicate predicateWithFormat:@"category = %@", self.catFilterString]];
        }
        if (self.areaFilterString != nil) {
            [predicates addObject:[NSPredicate predicateWithFormat:@"location.area = %@", self.areaFilterString]];
            
        }
        NSPredicate *compoundpred = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
        self.fetchPredicate = compoundpred;
    }
    
    self.animalsFetchedResultsController = nil;
    [AGCoreDataHelper performFetchOnFetchedResultsController:self.fetchedResultsController];
    [self.tableView reloadData];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setAnimalListTableView:nil];
    [super viewDidUnload];
}

- (void) barButtonItemFilterPressed: (id) sender {
   
    AGAnimalFilterViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGAnimalFilterViewController"];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
    vc.navigationController.navigationBar.tintColor = [UIColor blackColor];
    vc.delegate = self;
    vc.catFilterString = self.catFilterString;
    vc.areaFilterString = self.areaFilterString;
    [self presentViewController:navController animated:YES completion:nil];
}

#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
    
    NSInteger num = arc4random()%5;
//    NSInteger num = 4;
    NSString *imageName = [NSString stringWithFormat:@"latte%ihalb.png", num];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
    backgroundImage.image = [UIImage imageNamed:imageName];
    [headerView addSubview:backgroundImage];
    
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 22)];
    letterLabel.textColor = [UIColor whiteColor];
    letterLabel.backgroundColor = [UIColor clearColor];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.animalsFetchedResultsController sections] objectAtIndex:section];
    letterLabel.text = [sectionInfo name];
    letterLabel.font = [UIFont boldSystemFontOfSize:18];
    [headerView addSubview:letterLabel];
    return headerView;
 
}

- (NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (self.searchDisplayController.active) {
        return nil;
    } else {
        return [self.animalsFetchedResultsController sectionIndexTitles];
    }
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [self.animalsFetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.animalsFetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    
    static NSString *CellIdentifier = @"AGAnimalListTableCell";
    
    AGAnimalListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AGAnimalListTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UIView *selectionView = [[UIView alloc]initWithFrame:cell.bounds];
    
    [selectionView setBackgroundColor:Colors.waterBlueColor];
    
    cell.selectedBackgroundView = selectionView;
    
    Animal *an = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    cell.animalName.text = an.name;
    cell.animalThumbnail.image = [UIImage imageNamed:an.image];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AGAnimalDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGAnimalDetailViewController"];
    vc.currentAnimal = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];

    [self.navigationController pushViewController:vc animated:YES];

}

#pragma mark - NSFetchedResultsController

- (NSFetchedResultsController *) fetchedResultsController {
    
    if (self.animalsFetchedResultsController) {
        return self.animalsFetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Animal" inManagedObjectContext:[AGCoreDataHelper managedObjectContext]];
    fetchRequest.fetchBatchSize = 64;
    fetchRequest.predicate = self.fetchPredicate;
    fetchRequest.entity = entityDescription;
    
    NSSortDescriptor *sortName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    
    NSArray *sortArray = [NSArray arrayWithObject:sortName];
    fetchRequest.sortDescriptors = sortArray;
   
    self.animalsFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AGCoreDataHelper managedObjectContext] sectionNameKeyPath:@"name.stringGroupByFirstInitial" cacheName:nil];
    
    self.animalsFetchedResultsController.delegate = self;
    
    return self.animalsFetchedResultsController;

}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

#pragma - mark searchbar

- (void) barButtonItemSearchPressed: (id) sender {
    
    if (self.tableView.tableHeaderView == nil) { 
        [self.searchBar sizeToFit];
        self.tableView.tableHeaderView = self.searchBar;
        [self.tableView setContentOffset:CGPointMake(0, self.searchBar.frame.size.height) animated:NO];
        [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
    } else {
        self.searchBar.text = nil;
        [self searchBar:self.searchBar textDidChange:nil];
        if (self.tableView.contentOffset.y <= self.tableView.tableHeaderView.frame.size.height) {
            [self.tableView setContentOffset:CGPointMake(0, self.searchBar.frame.size.height) animated:YES];
          //  [self.tableView ]
            
            double delayInSeconds = 0.5;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                self.tableView.tableHeaderView = nil;
                [self.tableView setContentOffset:CGPointMake(0, 0) animated:NO];
            });
        } else {
            CGFloat yOffset = self.tableView.contentOffset.y - self.tableView.tableHeaderView.frame.size.height;
            self.tableView.tableHeaderView = nil;
            [self.tableView setContentOffset:CGPointMake(0, yOffset) animated:NO];
        }
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if(searchText.length > 0) {
        self.barButtonItemSearch.tintColor = Colors.waterBlueColor;
    } else {
        self.barButtonItemSearch.tintColor = nil;
    }
    
    if (searchText.length > 0) {
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
        self.fetchPredicate = filterPredicate;
    } else {
        self.fetchPredicate = self.basePredicate;
    }
    
    self.animalsFetchedResultsController = nil;
    [AGCoreDataHelper performFetchOnFetchedResultsController:self.fetchedResultsController];
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    if (self.searchBar.isFirstResponder) {
        [self.searchBar resignFirstResponder];
    }
}

@end
