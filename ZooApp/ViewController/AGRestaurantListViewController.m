//
//  AGRestaurantListViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 01.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGRestaurantListViewController.h"
#import "AGRestaurantListTableCell.h"
#import "Restaurant.h"
#import "AGCoreDataHelper.h"
#import "AGRestaurantDetailViewController.h"

@interface AGRestaurantListViewController ()

@end

@implementation AGRestaurantListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self.view setBackgroundColor:Colors.sandColor];
    [self.tableView setSeparatorColor:Colors.woodColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [[AGCoreDataHelper fetchEntitiesForClass:[Restaurant class] withPredicate:nil inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AGRestaurantListTableCell";
    
    AGRestaurantListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AGRestaurantListTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UIView *selectionView = [[UIView alloc]initWithFrame:cell.bounds];
    
    [selectionView setBackgroundColor:Colors.waterBlueColor];
    
    cell.selectedBackgroundView = selectionView;
    
   Restaurant *res = [[AGCoreDataHelper fetchEntitiesForClass:[Restaurant class] withPredicate:nil inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] objectAtIndex:indexPath.row];
    
    
    cell.restaurantName.text = res.name;
    cell.subtitle.text = res.ambience;
    cell.restaurantThumbnail.image = [UIImage imageNamed:res.image];
    
    return cell;

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AGRestaurantDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGRestaurantDetailViewController"];
    vc.currentRestaurant = [[AGCoreDataHelper fetchEntitiesForClass:[Restaurant class] withPredicate:nil inManagedObjectContext:[AGCoreDataHelper managedObjectContext]] objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}


@end
