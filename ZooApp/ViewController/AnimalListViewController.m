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
#import "AnimalManager.h"



@interface AnimalListViewController ()

@end

static NSString *filterKey;

@implementation AnimalListViewController 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        filterKey = [NSString new];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:Colors.sandColor];
    [self.tableView setSeparatorColor:Colors.darkGreenColor];
    filterKey = @"Alle Tiere";
 
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = filterKey;
    self.currentFilteredList = [[AnimalManager getInstance] getAnimalArrayForFilterKey:filterKey];
    
    self.alphabetArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    NSMutableArray* array = [NSMutableArray array];
    
    self.animalsData = [NSMutableDictionary dictionary];
    
    for (NSString* character in self.alphabetArray) {
        
        NSMutableArray *allAnimalsForLetter = [NSMutableArray array];
        
        for (Animal* p in self.currentFilteredList) {

            if ([p.name characterAtIndex:0] == [character characterAtIndex:0]) {
                
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

+ (void)setFilterKey: (NSString*) filKey {
    filterKey = filKey;
}

#pragma mark - table methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.indexArray.count;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90)];
    headerView.backgroundColor = Colors.darkGreenColor;
    UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 22)];
    letterLabel.textColor = [UIColor whiteColor];
    letterLabel.backgroundColor = Colors.darkGreenColor;
    letterLabel.text = [self.indexArray objectAtIndex:section];
    //letterLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:19];
    letterLabel.font = [UIFont boldSystemFontOfSize:19];
    [headerView addSubview:letterLabel];
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
    
    UIView *selectionView = [[UIView alloc]initWithFrame:cell.bounds];
    
    [selectionView setBackgroundColor:Colors.waterBlueColor];
    
    cell.selectedBackgroundView = selectionView;
    
    Animal *an = [[self.animalsData objectForKey:[self.indexArray objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];
    
    
    cell.textLabel.text = an.name;
   
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
