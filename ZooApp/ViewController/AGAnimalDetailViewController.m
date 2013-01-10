//
//  AGAnimalDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 08.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGAnimalDetailViewController.h"
#import "AGAnimalMapViewController.h"

@interface AGAnimalDetailViewController ()

@end

@implementation AGAnimalDetailViewController

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
    self.view.backgroundColor = Colors.sandColor;
    self.title = @"Details";
    UIBarButtonItem *mapButton = [[UIBarButtonItem alloc] initWithTitle:@"Zooplan" style:UIBarButtonItemStylePlain target:self action:@selector(showAnimalOnMap)];
    self.navigationItem.rightBarButtonItem = mapButton;
    
    self.animalImageView.image = [UIImage imageNamed:self.currentAnimal.image];
    self.animalNameLabel.text = self.currentAnimal.name;
    self.enclosureLabel.text = [NSString stringWithFormat:@"Gehege: %@", self.currentAnimal.enclosure];
    self.areaLabel.text = [NSString stringWithFormat:@"Themenwelt: %@", self.currentAnimal.area];
    self.feedingLabel.text = self.currentAnimal.feedingTime;
    self.commentaryLabel.text = self.currentAnimal.commentaryTime;
    
    self.favAnimal = NO;
    self.favFeedingTime = NO;
    self.favCommentaryTime = NO;
    
    [self checkFavStatus];
    [self createChalkboardView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEnclosureLabel:nil];
    [self setAreaLabel:nil];
    [self setDistanceLabel:nil];
    [self setDirectionLabel:nil];
    [self setChalkboardScrollView:nil];
    [self setChalkboardPageControl:nil];
    [self setAnimalImageView:nil];
    [self setAnimalNameLabel:nil];
    [self setFeedingLabel:nil];
    [self setCommentaryLabel:nil];
    [self setFavAnimalButton:nil];
    [self setFavFeedingButton:nil];
    [self setFavCommentaryButton:nil];
    [super viewDidUnload];
}


- (void)createChalkboardView {
    
    NSArray *chalkboardHeading = [[NSArray alloc] initWithObjects:
                                  @"Kategorie",
                                  @"Verwandschaft",
                                  @"Lebensraum",
                                  @"Höchstalter",
                                  @"Größe",
                                  @"Gewicht",
                                  @"Sozialstruktur",
                                  @"Fortpflanzung",
                                  @"Feinde",
                                  @"Nahrung",
                                  @"Bedrohungsstatus",
                                  nil];
    
    NSArray *chalkboardContent = [[NSArray alloc] initWithObjects:
                                  self.currentAnimal.category,
                                  self.currentAnimal.relationship,
                                  self.currentAnimal.habitat,
                                  self.currentAnimal.maximumAge,
                                  self.currentAnimal.size,
                                  self.currentAnimal.weight,
                                  self.currentAnimal.socialStructure,
                                  self.currentAnimal.propagation,
                                  self.currentAnimal.enemies,
                                  self.currentAnimal.food,
                                  self.currentAnimal.threadState,
                                  nil];


    CGRect contentFrame = CGRectMake(0, 0, 230, 180);
    contentFrame.origin.y = 0;
    self.chalkboardScrollView.frame = contentFrame;
    
    for (int i = 0; i < chalkboardContent.count; i++) {
        
        contentFrame.origin.x = self.chalkboardScrollView.frame.size.width * i;
    
        UIView *contentView = [[UIView alloc] initWithFrame:contentFrame];
        //contentView.backgroundColor = [UIColor orangeColor];
        
        UILabel *heading = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 210, 28)];
        heading.text = [chalkboardHeading objectAtIndex:i];
        heading.font = [UIFont boldSystemFontOfSize:16];
        heading.textColor = [UIColor whiteColor];
        heading.backgroundColor = [UIColor clearColor];
        [contentView addSubview:heading];
       
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, 32, 210, 152)];
        content.text = [chalkboardContent objectAtIndex:i];
        content.textColor = [UIColor whiteColor];
        content.lineBreakMode = UILineBreakModeWordWrap;
        content.numberOfLines = 0;
        content.backgroundColor = [UIColor clearColor];
        [content sizeToFit];
        [contentView addSubview:content];
        
        [self.chalkboardScrollView addSubview:contentView];
        
        if ([self.currentAnimal.feedingTime isEqualToString:@"nicht öffentlich"]) {
            self.favFeedingButton.hidden = YES;
        }
        if ([self.currentAnimal.commentaryTime isEqualToString:@"nicht öffentlich"]) {
            self.favCommentaryButton.hidden = YES;
        }
    }
    
    self.chalkboardScrollView.contentSize = CGSizeMake(self.chalkboardScrollView.frame.size.width * chalkboardContent.count, self.chalkboardScrollView.frame.size.height);
    self.chalkboardPageControl.numberOfPages = chalkboardContent.count;
  
}


- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.chalkboardScrollView.frame.size.width;
    int page = floor((self.chalkboardScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.chalkboardPageControl.currentPage = page;
    
}
 

- (IBAction)pageChanged:(id)sender {
    // update the scroll view to the appropriate page
    CGRect frame;
    frame.origin.x = self.chalkboardScrollView.frame.size.width * self.chalkboardPageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.chalkboardScrollView.frame.size;
    [self.chalkboardScrollView scrollRectToVisible:frame animated:YES];
}


- (void)checkFavStatus {
    if (self.favAnimal == NO) {
        [self.favAnimalButton setImage:[UIImage imageNamed:@"greyStarFav.png"] forState:UIControlStateNormal];
    } else {
        [self.favAnimalButton setImage:[UIImage imageNamed:@"goldStarFav.png"] forState:UIControlStateNormal];
    }
    
    if (self.favFeedingTime == NO) {
        [self.favFeedingButton setImage:[UIImage imageNamed:@"greyStarFav.png"] forState:UIControlStateNormal];
    } else {
        [self.favFeedingButton setImage:[UIImage imageNamed:@"goldStarFav.png"] forState:UIControlStateNormal];
    }
    
    if (self.favCommentaryTime == NO) {
        [self.favCommentaryButton setImage:[UIImage imageNamed:@"greyStarFav.png"] forState:UIControlStateNormal];
    } else {
        [self.favCommentaryButton setImage:[UIImage imageNamed:@"goldStarFav.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)favAnimalButtonPressed:(id)sender {
    if (self.favAnimal == NO) {
        self.favAnimal = YES;
    } else {
        self.favAnimal = NO;
    }
    [self checkFavStatus];
}

- (IBAction)favFeedingButtonPressed:(id)sender {
    if (self.favFeedingTime == NO) {
        self.favFeedingTime = YES;
    } else {
        self.favFeedingTime = NO;
    }
    [self checkFavStatus];
}

- (IBAction)favCommentaryButtonPressed:(id)sender {
    if (self.favCommentaryTime == NO) {
        self.favCommentaryTime = YES;
    } else {
        self.favCommentaryTime = NO;
    }
    [self checkFavStatus];
}

- (void)showAnimalOnMap {
    AGAnimalMapViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"AGAnimalMapViewController"];
    vc.currentAnimal = self.currentAnimal;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
