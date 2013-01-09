//
//  AnimalFilterViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 24.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalFilterViewController.h"
#import "AnimalFilterTableCell.h"
#import "AGAnimalListViewController.h"
#import "AnimalManager.h"

@interface AnimalFilterViewController ()



@end

@implementation AnimalFilterViewController

    AnimalManager *aM;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    aM = [AnimalManager getInstance];
    
    [self createFilterCategories];
    
    [self.view setBackgroundColor:Colors.sandColor];
    [self.tableView setSeparatorColor:Colors.darkGreenColor];
    
    self.filterOptions = [[NSArray alloc] initWithObjects:@"Kein Filter", @"Tiere nach Kategorien", @"Tiere nach Themenwelten",nil];
    
    self.filterCategoryData = [NSMutableDictionary dictionary];
    
    NSMutableArray *animalCategoryFilterOption = [NSMutableArray array];
    NSMutableArray *areaCategoryFilterOption = [NSMutableArray array];
    NSMutableArray *noCategoryFilterOption = [NSMutableArray array];
    
    for (NSArray* filterCategory in self.filterCategories) {
        
        if ([filterCategory objectAtIndex:2] == @"animalCategory") {
            [animalCategoryFilterOption addObject:filterCategory];
        } else if ([filterCategory objectAtIndex:2] == @"areaCategory") {
            [areaCategoryFilterOption addObject:filterCategory];
        } else if ([filterCategory objectAtIndex:2] == @"noCategory") {
            [noCategoryFilterOption addObject:filterCategory];
        }
    }
    
    [self.filterCategoryData setObject:noCategoryFilterOption forKey:[self.filterOptions objectAtIndex:0]];
    [self.filterCategoryData setObject:animalCategoryFilterOption forKey:[self.filterOptions objectAtIndex:1]];
    [self.filterCategoryData setObject:areaCategoryFilterOption forKey:[self.filterOptions objectAtIndex:2]];

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
       
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90)];
    headerView.backgroundColor = Colors.darkGreenColor;
    UILabel *optionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 22)];
    optionLabel.textColor = [UIColor whiteColor];
    optionLabel.backgroundColor = Colors.darkGreenColor;
    optionLabel.text = [self.filterOptions objectAtIndex:section];
    //optionLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:19];
    optionLabel.font = [UIFont boldSystemFontOfSize:19];
    [headerView addSubview:optionLabel];
    return headerView;
}

- (void)createFilterCategories {
    
    self.filterCategories = [NSMutableArray new];
    
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Alle Tiere" imageName:@"allAnimals.png" category:@"noCategory"]];
   
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Säugetiere" imageName:@"mammals.png" category:@"animalCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Vögel" imageName:@"birds.png" category:@"animalCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Reptilien" imageName:@"reptiles.png" category:@"animalCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Amphibien" imageName:@"amphibians.png" category:@"animalCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Wirbellose Tiere" imageName:@"invertebrates.png" category:@"animalCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Fische" imageName:@"fish.png" category:@"animalCategory"]];
    
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Gründer-Garten" imageName:@"foundersGarden.png" category:@"areaCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Gondwanaland" imageName:@"gondwanaland.png" category:@"areaCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Asien" imageName:@"asia.png" category:@"areaCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Pongoland" imageName:@"pongoland.png" category:@"areaCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Afrika" imageName:@"africa.png" category:@"areaCategory"]];
    [self.filterCategories addObject:[self createFilterCategoryWithTitleKey:@"Südamerika" imageName:@"southAmerica.png" category:@"areaCategory"]];
}

- (NSMutableArray*) createFilterCategoryWithTitleKey:(NSString*)tK imageName:(NSString*)iN category:(NSString*)c {
    
    NSMutableArray *row = [NSMutableArray new];
    [row addObject:tK];
    [row addObject:[UIImage imageNamed:iN]];
    [row addObject:c];
    [row addObject:[NSNumber numberWithInt:[[aM.filteredAnimalList objectForKey:tK] count]]];
    return row;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //return self.filterCategories.count;
    return  [[self.filterCategoryData objectForKey:[self.filterOptions objectAtIndex:section]] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.filterOptions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AnimalFilterCell";
    
    AnimalFilterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnimalFilterTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    UIView *selectionView = [[UIView alloc]initWithFrame:cell.bounds];
    
    [selectionView setBackgroundColor:Colors.waterBlueColor];
    
    cell.selectedBackgroundView = selectionView;
    
    
    
    NSArray *filteredCategory = [[self.filterCategoryData objectForKey:[self.filterOptions objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];

    NSString *entry = [NSString new];
    
    int numberOfEntries = [[filteredCategory objectAtIndex:3] intValue];
    
    if (numberOfEntries == 1) {
        entry = @"Eintrag";
    } else {
        entry = @"Einträge";
    }
    
    
    cell.animalFilterTitleLabel.text = [filteredCategory objectAtIndex:0];
    cell.animalFilterImageView.image = [filteredCategory objectAtIndex:1];
    cell.animalSubtitleLabel.text = [NSString stringWithFormat:@"%d %@", numberOfEntries, entry];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
    NSString *filteredCategory = [[[self.filterCategoryData objectForKey:[self.filterOptions objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row] objectAtIndex:0];
    
    [AGAnimalListViewController setFilterKey:filteredCategory];
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
