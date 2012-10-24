//
//  AnimalFilterViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 24.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalFilterViewController.h"
#import "AnimalFilterTableCell.h"

@interface AnimalFilterViewController ()

@end

@implementation AnimalFilterViewController

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
    optionLabel.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:19];
    [headerView addSubview:optionLabel];
    return headerView;
}

- (void)createFilterCategories {
    
    NSMutableArray *rowAll = [NSMutableArray new];
    [rowAll addObject:@"Alle Tiere"];
    [rowAll addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowAll addObject:@"noCategory"];
    
    NSMutableArray *rowMammal = [NSMutableArray new];
    [rowMammal addObject:@"Säugetiere"];
    [rowMammal addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowMammal addObject:@"animalCategory"];
    
    NSMutableArray *rowBirds = [NSMutableArray new];
    [rowBirds addObject:@"Vögel"];
    [rowBirds addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowBirds addObject:@"animalCategory"];
    
    NSMutableArray *rowReptiles = [NSMutableArray new];
    [rowReptiles addObject:@"Reptilien"];
    [rowReptiles addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowReptiles addObject:@"animalCategory"];
    
    NSMutableArray *rowAmphibians = [NSMutableArray new];
    [rowAmphibians addObject:@"Amphibien"];
    [rowAmphibians addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowAmphibians addObject:@"animalCategory"];
    
    NSMutableArray *rowInvertebrates = [NSMutableArray new];
    [rowInvertebrates addObject:@"Wirbellose Tiere"];
    [rowInvertebrates addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowInvertebrates addObject:@"animalCategory"];
    
    NSMutableArray *rowFish = [NSMutableArray new];
    [rowFish addObject:@"Fische"];
    [rowFish addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowFish addObject:@"animalCategory"];
    
    NSMutableArray *rowFoundersGarden = [NSMutableArray new];
    [rowFoundersGarden addObject:@"Gründergarten"];
    [rowFoundersGarden addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowFoundersGarden addObject:@"areaCategory"];
    
    NSMutableArray *rowGondwanaLand = [NSMutableArray new];
    [rowGondwanaLand addObject:@"Gondwanaland"];
    [rowGondwanaLand addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowGondwanaLand addObject:@"areaCategory"];
    
    NSMutableArray *rowAsia = [NSMutableArray new];
    [rowAsia addObject:@"Asien"];
    [rowAsia addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowAsia addObject:@"areaCategory"];
    
    NSMutableArray *rowPongoland = [NSMutableArray new];
    [rowPongoland addObject:@"Pongoland"];
    [rowPongoland addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowPongoland addObject:@"areaCategory"];
    
    NSMutableArray *rowAfrica = [NSMutableArray new];
    [rowAfrica addObject:@"Afrika"];
    [rowAfrica addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowAfrica addObject:@"areaCategory"];
    
    NSMutableArray *rowSouthAmerica = [NSMutableArray new];
    [rowSouthAmerica addObject:@"Südamerika"];
    [rowSouthAmerica addObject:[UIImage imageNamed:@"Icon-72.png"]];
    [rowSouthAmerica addObject:@"areaCategory"];
    
    self.filterCategories = [[NSArray alloc] initWithObjects:rowAll, rowMammal, rowBirds, rowReptiles, rowAmphibians, rowInvertebrates,rowFish, rowFoundersGarden, rowGondwanaLand, rowAsia, rowPongoland, rowAfrica, rowSouthAmerica, nil];
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
    
    NSArray *ar = [[self.filterCategoryData objectForKey:[self.filterOptions objectAtIndex:indexPath.section]]  objectAtIndex:indexPath.row];

    
    cell.animalFilterTitleLabel.text = [ar objectAtIndex:0];
    cell.animalFilterImageView.image = [ar objectAtIndex:1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
