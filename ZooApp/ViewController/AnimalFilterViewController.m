//
//  AnimalFilterViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 24.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalFilterViewController.h"
#import "AnimalFilterTableCell.h"
#import "AnimalListViewController.h"
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
    
    NSMutableArray *rowAll = [NSMutableArray new];
    [rowAll addObject:@"Alle Tiere"];
    [rowAll addObject:[UIImage imageNamed:@"allAnimals.png"]];
    [rowAll addObject:@"noCategory"];
    [rowAll addObject:[NSNumber numberWithInt:aM.allAnimals.count]];
    [self.filterCategories addObject:rowAll];
    
    NSMutableArray *rowMammal = [NSMutableArray new];
    [rowMammal addObject:@"Säugetiere"];
    [rowMammal addObject:[UIImage imageNamed:@"mammals.png"]];
    [rowMammal addObject:@"animalCategory"];
    [rowMammal addObject:[NSNumber numberWithInt:aM.allMammals.count]];
    [self.filterCategories addObject:rowMammal];
    
    NSMutableArray *rowBirds = [NSMutableArray new];
    [rowBirds addObject:@"Vögel"];
    [rowBirds addObject:[UIImage imageNamed:@"birds.png"]];
    [rowBirds addObject:@"animalCategory"];
    [rowBirds addObject:[NSNumber numberWithInt:aM.allBirds.count]];
    [self.filterCategories addObject:rowBirds];
    
    NSMutableArray *rowReptiles = [NSMutableArray new];
    [rowReptiles addObject:@"Reptilien"];
    [rowReptiles addObject:[UIImage imageNamed:@"reptiles.png"]];
    [rowReptiles addObject:@"animalCategory"];
    [rowReptiles addObject:[NSNumber numberWithInt:aM.allReptiles.count]];
    [self.filterCategories addObject:rowReptiles];
    
    NSMutableArray *rowAmphibians = [NSMutableArray new];
    [rowAmphibians addObject:@"Amphibien"];
    [rowAmphibians addObject:[UIImage imageNamed:@"amphibians.png"]];
    [rowAmphibians addObject:@"animalCategory"];
    [rowAmphibians addObject:[NSNumber numberWithInt:aM.allAmphibians.count]];
    [self.filterCategories addObject:rowAmphibians];
    
    NSMutableArray *rowInvertebrates = [NSMutableArray new];
    [rowInvertebrates addObject:@"Wirbellose Tiere"];
    [rowInvertebrates addObject:[UIImage imageNamed:@"invertebrates.png"]];
    [rowInvertebrates addObject:@"animalCategory"];
    [rowInvertebrates addObject:[NSNumber numberWithInt:aM.allInvertebrates.count]];
    [self.filterCategories addObject:rowInvertebrates];
    
    NSMutableArray *rowFish = [NSMutableArray new];
    [rowFish addObject:@"Fische"];
    [rowFish addObject:[UIImage imageNamed:@"fish.png"]];
    [rowFish addObject:@"animalCategory"];
    [rowFish addObject:[NSNumber numberWithInt:aM.allFish.count]];
    [self.filterCategories addObject:rowFish];
    
    NSMutableArray *rowFoundersGarden = [NSMutableArray new];
    [rowFoundersGarden addObject:@"Gründer-Garten"];
    [rowFoundersGarden addObject:[UIImage imageNamed:@"foundersGarden.png"]];
    [rowFoundersGarden addObject:@"areaCategory"];
    [rowFoundersGarden addObject:[NSNumber numberWithInt:aM.allFoundersGardenAnimals.count]];
    [self.filterCategories addObject:rowFoundersGarden];
    
    NSMutableArray *rowGondwanaLand = [NSMutableArray new];
    [rowGondwanaLand addObject:@"Gondwanaland"];
    [rowGondwanaLand addObject:[UIImage imageNamed:@"gondwanaland.png"]];
    [rowGondwanaLand addObject:@"areaCategory"];
    [rowGondwanaLand addObject:[NSNumber numberWithInt:aM.allGondwanalandAnimals.count]];
    [self.filterCategories addObject:rowGondwanaLand];
    
    NSMutableArray *rowAsia = [NSMutableArray new];
    [rowAsia addObject:@"Asien"];
    [rowAsia addObject:[UIImage imageNamed:@"asia.png"]];
    [rowAsia addObject:@"areaCategory"];
    [rowAsia addObject:[NSNumber numberWithInt:aM.allAsiaAnimals.count]];
    [self.filterCategories addObject:rowAsia];
    
    NSMutableArray *rowPongoland = [NSMutableArray new];
    [rowPongoland addObject:@"Pongoland"];
    [rowPongoland addObject:[UIImage imageNamed:@"pongoland.png"]];
    [rowPongoland addObject:@"areaCategory"];
    [rowPongoland addObject:[NSNumber numberWithInt:aM.allPongolandAnimals.count]];
    [self.filterCategories addObject:rowPongoland];
    
    NSMutableArray *rowAfrica = [NSMutableArray new];
    [rowAfrica addObject:@"Afrika"];
    [rowAfrica addObject:[UIImage imageNamed:@"africa.png"]];
    [rowAfrica addObject:@"areaCategory"];
    [rowAfrica addObject:[NSNumber numberWithInt:aM.allAfricaAnimals.count]];
    [self.filterCategories addObject:rowAfrica];
    
    NSMutableArray *rowSouthAmerica = [NSMutableArray new];
    [rowSouthAmerica addObject:@"Südamerika"];
    [rowSouthAmerica addObject:[UIImage imageNamed:@"southAmerica.png"]];
    [rowSouthAmerica addObject:@"areaCategory"];
    [rowSouthAmerica addObject:[NSNumber numberWithInt:aM.allSouthAmericaAnimals.count]];
    [self.filterCategories addObject:rowSouthAmerica];
    
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
    
    if ([filteredCategory isEqualToString:@"Alle Tiere"]) {
        aM.filterTypeForAnimalListViewController = FILTER_ALLANIMALS;
    } else if ([filteredCategory isEqualToString:@"Säugetiere"]) {
        aM.filterTypeForAnimalListViewController = FILTER_MAMMALS;
    } else if ([filteredCategory isEqualToString:@"Vögel"]) {
        aM.filterTypeForAnimalListViewController = FILTER_BIRDS;
    } else if ([filteredCategory isEqualToString:@"Reptilien"]) {
        aM.filterTypeForAnimalListViewController = FILTER_REPTILES;
    } else if ([filteredCategory isEqualToString:@"Amphibien"]) {
        aM.filterTypeForAnimalListViewController = FILTER_AMPHIBIANS;
    } else if ([filteredCategory isEqualToString:@"Wirbellose Tiere"]) {
        aM.filterTypeForAnimalListViewController = FILTER_INVERTEBRATES;
    } else if ([filteredCategory isEqualToString:@"Fische"]) {
        aM.filterTypeForAnimalListViewController = FILTER_FISH;
    } else if ([filteredCategory isEqualToString:@"Gründer-Garten"]) {
        aM.filterTypeForAnimalListViewController = FILTER_FOUNDERSGARDEN;
    } else if ([filteredCategory isEqualToString:@"Gondwanaland"]) {
        aM.filterTypeForAnimalListViewController = FILTER_GONDWANALAND;
    } else if ([filteredCategory isEqualToString:@"Asien"]) {
        aM.filterTypeForAnimalListViewController = FILTER_ASIA;
    } else if ([filteredCategory isEqualToString:@"Pongoland"]) {
        aM.filterTypeForAnimalListViewController = FILTER_PONGOLAND;
    } else if ([filteredCategory isEqualToString:@"Afrika"]) {
        aM.filterTypeForAnimalListViewController = FILTER_AFRICA;
    } else if ([filteredCategory isEqualToString:@"Südamerika"]) {
        aM.filterTypeForAnimalListViewController = FILTER_SOUTHAMERICA;
    } 

    [self.navigationController popViewControllerAnimated:YES];
}

@end
