//
//  AGInfoListViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 14.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGInfoListViewController.h"
#import "AGInfoDetailViewController.h"
#import "AGInfoDetailWebViewController.h"
#import "AGRestaurantListViewController.h"

@interface AGInfoListViewController ()

@end

@implementation AGInfoListViewController

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
    [self.view setBackgroundColor:Colors.sandColor];
    [self.tableView setSeparatorColor:Colors.woodColor];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSArray *section0 = [[NSArray alloc] initWithObjects:@"openingHours", @"prices", @"no", nil];

    NSArray *section1 = [[NSArray alloc] initWithObjects:@"guidedTours", @"no", @"no", @"events", nil];

    NSArray *section2 = [[NSArray alloc] initWithObjects:@"restaurants", @"wheelchairAccess", @"lockers", @"kidsService", @"zooRules", nil];

    self.htmlArray = [[NSArray alloc] initWithObjects:section0, section1, section2, nil];
    
    self.keyArray = [[NSArray alloc] initWithObjects:@"Zooinformationen", @"Aktivitäten", @"Service", nil];
    
    NSArray *zooInfoArray = [[NSArray alloc] initWithObjects:@"Öffnungszeiten", @"Preise", @"Anfahrt", nil];
    NSArray *activityArray = [[NSArray alloc] initWithObjects:@"Führungen", @"Fütterungszeiten", @"Kommentierungszeiten", @"Veranstaltungen", nil];
    NSArray *serviceArray = [[NSArray alloc] initWithObjects:@"Gastronomie", @"Barrierefreiheit", @"Schließfächer", @"Kinderservice", @"Zooordnung", nil];
    
    self.infoData = [NSMutableDictionary dictionary];
    [self.infoData setObject:zooInfoArray forKey:[self.keyArray objectAtIndex:0]];
    [self.infoData setObject:activityArray forKey:[self.keyArray objectAtIndex:1]];
    [self.infoData setObject:serviceArray forKey:[self.keyArray objectAtIndex:2]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.infoData.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
    
    NSInteger num = arc4random()%5;
    NSString *imageName = [NSString stringWithFormat:@"latte%ihalb.png", num];
    UIImageView *backgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 22)];
    backgroundImage.image = [UIImage imageNamed:imageName];
    [headerView addSubview:backgroundImage];
    
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 22)];
    letterLabel.textColor = [UIColor whiteColor];
    letterLabel.backgroundColor = [UIColor clearColor];
    letterLabel.text = [self.keyArray objectAtIndex:section];
    letterLabel.font = [UIFont boldSystemFontOfSize:17];
    [headerView addSubview:letterLabel];
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.infoData objectForKey:[self.keyArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"InfoCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UIView *selectionView = [[UIView alloc]initWithFrame:cell.bounds];
    
    [selectionView setBackgroundColor:Colors.waterBlueColor];
    
    cell.selectedBackgroundView = selectionView;
    
    NSString *listEntry = [[self.infoData objectForKey:[self.keyArray objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];
    
    cell.textLabel.text = listEntry;
    
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int numberOfSelectedSection = [self.tableView indexPathForSelectedRow].section;
    int numberOfSelectedRow = [self.tableView indexPathForSelectedRow].row;
    
    NSString *htmlString = (NSString*)[[self.htmlArray objectAtIndex:numberOfSelectedSection] objectAtIndex:numberOfSelectedRow];
    
    if ([htmlString isEqualToString:@"no"]) {
        
        AGInfoDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGInfoDetailViewController"];
        vc.title = @"No Web";
        [self.navigationController pushViewController:vc animated:YES];
    
    } else if ([htmlString isEqualToString:@"restaurants"]) {
        
        AGInfoDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGRestaurantListViewController"];
        vc.title = @"Gastronomie";
        [self.navigationController pushViewController:vc animated:YES];
        
    } else {
    
        AGInfoDetailWebViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGInfoDetailWebViewController"];
        vc.title = @"Info";
        vc.htmlName = htmlString;
        
        [self.navigationController pushViewController:vc animated:YES];

    }

}

@end
