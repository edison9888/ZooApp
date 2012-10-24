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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor yellowColor]];
   
    NSMutableArray *rowAll = [NSMutableArray new];
    [rowAll addObject:@"Alle Tiere"];
    [rowAll addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowMammal = [NSMutableArray new];
    [rowMammal addObject:@"Säugetiere"];
    [rowMammal addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowBirds = [NSMutableArray new];
    [rowBirds addObject:@"Vögel"];
    [rowBirds addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowReptiles = [NSMutableArray new];
    [rowReptiles addObject:@"Reptilien"];
    [rowReptiles addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowAmphibians = [NSMutableArray new];
    [rowAmphibians addObject:@"Amphibien"];
    [rowAmphibians addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowInvertebrates = [NSMutableArray new];
    [rowInvertebrates addObject:@"Wirbellose Tiere"];
    [rowInvertebrates addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowFish = [NSMutableArray new];
    [rowFish addObject:@"Fische"];
    [rowFish addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowFoundersGarden = [NSMutableArray new];
    [rowFoundersGarden addObject:@"Gründergarten"];
    [rowFoundersGarden addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowGondwanaLand = [NSMutableArray new];
    [rowGondwanaLand addObject:@"Gondwanaland"];
    [rowGondwanaLand addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowAsia = [NSMutableArray new];
    [rowAsia addObject:@"Asien"];
    [rowAsia addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowPongoland = [NSMutableArray new];
    [rowPongoland addObject:@"Pongoland"];
    [rowPongoland addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowAfrica = [NSMutableArray new];
    [rowAfrica addObject:@"Afrika"];
    [rowAfrica addObject:[UIImage imageNamed:@"Icon-72.png"]];
    
    NSMutableArray *rowSouthAmerica = [NSMutableArray new];
    [rowSouthAmerica addObject:@"Südamerika"];
    [rowSouthAmerica addObject:[UIImage imageNamed:@"Icon-72.png"]];
    

    self.filterCategories = [[NSArray alloc] initWithObjects:rowAll, rowMammal, rowBirds, rowReptiles, rowAmphibians, rowInvertebrates,rowFish, rowFoundersGarden, rowGondwanaLand, rowAsia, rowPongoland, rowAfrica, rowSouthAmerica, nil];
    


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - table methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filterCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"AnimalFilterCell";
    
    AnimalFilterTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"AnimalFilterTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    NSArray *ar = [self.filterCategories objectAtIndex:indexPath.row];
    
    cell.animalFilterTitleLabel.text = [ar objectAtIndex:0];
    cell.animalFilterImageView.image = [ar objectAtIndex:1];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
