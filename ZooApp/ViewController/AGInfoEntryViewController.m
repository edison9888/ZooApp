//
//  AGInfoEntryViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 28.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGInfoEntryViewController.h"

@interface AGInfoEntryViewController ()

@end

@implementation AGInfoEntryViewController

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
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor:Colors.sandColor];
    [self.tableView setSeparatorColor:Colors.woodColor];

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"InfoEntryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    UIView *backgroundView = [[UIView alloc]initWithFrame:cell.bounds];
    
    [backgroundView setBackgroundColor:Colors.sandColor];
    
    cell.backgroundView = backgroundView;
    
   // NSString *listEntry = [[self.infoData objectForKey:[self.keyArray objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];
    
    cell.textLabel.text = @"Besucherinformationen";
    
    return cell;
}

@end
