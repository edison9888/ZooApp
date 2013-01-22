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
#import "AGAnimalManager.h"
#import "AGAnimalListTableCell.h"



@interface AGAnimalListViewController ()

@end

static NSString *filterKey;

@implementation AGAnimalListViewController

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
    [self.tableView setSeparatorColor:Colors.woodColor];
    filterKey = @"Alle Tiere";
 
}

- (void)viewWillAppear:(BOOL)animated {
    
    self.navigationItem.title = filterKey;
    self.currentFilteredList = [[AGAnimalManager sharedInstance] getAnimalArrayForFilterKey:filterKey];
    
    self.alphabetArray = [[NSArray alloc] initWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    NSMutableArray* array = [NSMutableArray array];
    
    self.animalsData = [NSMutableDictionary dictionary];
    
    for (NSString* character in self.alphabetArray) {
        
        NSMutableArray *allAnimalsForLetter = [NSMutableArray array];
        
        for (AGAnimal* p in self.currentFilteredList) {

            if ([p.name characterAtIndex:0] == [character characterAtIndex:0]) {
                
                if (![array containsObject:character]) {
                    [array addObject:character];
                }
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
    letterLabel.text = [self.indexArray objectAtIndex:section];
    letterLabel.font = [UIFont boldSystemFontOfSize:18];
    [headerView addSubview:letterLabel];
    return headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[self.animalsData objectForKey:[self.indexArray objectAtIndex:section]] count];
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
    
    AGAnimal *an = [[self.animalsData objectForKey:[self.indexArray objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];
    
    
    cell.animalName.text = an.name;
    cell.animalThumbnail.image = [UIImage imageNamed:an.image];
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AGAnimalDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGAnimalDetailViewController"];
    int numberOfSelectedSection = [self.tableView indexPathForSelectedRow].section;
    int numberOfSelectedRow = [self.tableView indexPathForSelectedRow].row;
    vc.currentAnimal = [[self.animalsData objectForKey:[self.indexArray objectAtIndex:numberOfSelectedSection]]  objectAtIndex:numberOfSelectedRow];
    [self.navigationController pushViewController:vc animated:YES];

}


@end
