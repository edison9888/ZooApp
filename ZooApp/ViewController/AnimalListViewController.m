//
//  AnimalListViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalListViewController.h"
#import "AnimalDetailViewController.h"
#import "Animal.h"

@interface AnimalListViewController ()

@end

@implementation AnimalListViewController 

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
    
    self.alphabetArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    NSMutableArray* array = [NSMutableArray array];
    
    self.animalsData = [NSMutableDictionary dictionary];
    
    for (NSString* character in self.alphabetArray) {
        
        NSMutableArray *allAnimalsForLetter = [NSMutableArray array];
        
        for (Animal* p in Animal.getAllAnimals) {

            if ([p.species characterAtIndex:0] == [character characterAtIndex:0]) {
                
                if (![array containsObject:character])
                    [array addObject:character];
                [allAnimalsForLetter addObject:p];
            }
        }
        if (allAnimalsForLetter.count > 0) {
            [self.animalsData setObject:allAnimalsForLetter forKey:character];
        }

    }

    self.indexArray = [NSArray arrayWithArray:array];
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


#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexArray.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor greenColor];
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    dateLabel.textColor = [UIColor blueColor];
    dateLabel.backgroundColor = [UIColor redColor];
    dateLabel.text = [self.indexArray objectAtIndex:section];
    [headerView addSubview:dateLabel];
    return headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[self.animalsData objectForKey:[self.indexArray objectAtIndex:section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AnimalListCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Animal *an = [[self.animalsData objectForKey:[self.indexArray objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = an.species;
   
    return cell;
}


#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showAnimalDetailView"]) {
        AnimalDetailViewController *controller = segue.destinationViewController;
        int numberOfSelectedSection = [self.tableView indexPathForSelectedRow].section;
        int numberOfSelectedRow = [self.tableView indexPathForSelectedRow].row;
        controller.currentAnimal = [[self.animalsData objectForKey:[self.indexArray objectAtIndex:numberOfSelectedSection]]  objectAtIndex:numberOfSelectedRow];
        return;
    }
   
}

@end
