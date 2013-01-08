//
//  AnimalDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import "AnimalDetailViewController.h"
#import "AnimalMapViewController.h"

#define LABELWIDTH 300

#define HEADLINE_HEIGHT 30
#define HEADING_LABEL_HEIGHT 30
#define GAP_BETWEEN_ENTRIES 15

@interface AnimalDetailViewController ()

@end

@implementation AnimalDetailViewController

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
   
//    [self.view setBackgroundColor:Colors.sandColor];

    // Set the background
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    //[self.view addSubview:imageView];

    self.view.backgroundColor = Colors.sandColor;
    
  //  self.navigationItem.title = @"";
    
    
    int startY = 15;
    
    UIImageView *animalImage =[[UIImageView alloc] initWithImage:[UIImage imageNamed:self.currentAnimal.image]];

    animalImage.frame = CGRectMake(10, startY, LABELWIDTH, 150);
//    animalImage.backgroundColor = Colors.darkGreenColor;
    [self.view addSubview:animalImage];
    
    startY += animalImage.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UILabel *headline = [[UILabel alloc] initWithFrame:CGRectMake(10, startY, LABELWIDTH, HEADLINE_HEIGHT)];
    headline.text = self.currentAnimal.name;
    headline.textColor = [UIColor blackColor];
   // headline.textColor = Colors.darkGreenColor;
    headline.font = [UIFont boldSystemFontOfSize:19];
    headline.backgroundColor = [UIColor clearColor];

    [self.view addSubview:headline];
    
    startY += HEADLINE_HEIGHT+GAP_BETWEEN_ENTRIES;
    
    self.detailAnimalScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, startY, 320, 230)];
    //self.detailAnimalScrollView.backgroundColor = [UIColor redColor];
    
    startY = 0;
    
    UIView *verwandschaftView = [self createViewForEntryWithHeadline:@"Verwandschaft" entry:self.currentAnimal.verwandschaft startY:startY];
    [self.detailAnimalScrollView addSubview:verwandschaftView];
    
    startY += verwandschaftView.frame.size.height+GAP_BETWEEN_ENTRIES;

    UIView *lebensraumView = [self createViewForEntryWithHeadline:@"Lebensraum" entry:self.currentAnimal.lebensraum startY:startY];
    [self.detailAnimalScrollView addSubview:lebensraumView];
    
    startY += lebensraumView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *hoechstalterView = [self createViewForEntryWithHeadline:@"Höchstalter" entry:self.currentAnimal.hoechstalter startY:startY];
    [self.detailAnimalScrollView addSubview:hoechstalterView];

    startY += hoechstalterView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *groesseView = [self createViewForEntryWithHeadline:@"Größe" entry:self.currentAnimal.groesse startY:startY];
    [self.detailAnimalScrollView addSubview:groesseView];

    startY += groesseView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *gewichtView = [self createViewForEntryWithHeadline:@"Gewicht" entry:self.currentAnimal.gewicht startY:startY];
    [self.detailAnimalScrollView addSubview:gewichtView];

    startY += gewichtView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *sozialstrukturView = [self createViewForEntryWithHeadline:@"Sozialstruktur" entry:self.currentAnimal.sozialstruktur startY:startY];
    [self.detailAnimalScrollView addSubview:sozialstrukturView];

    startY += sozialstrukturView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *fortpflanzungView = [self createViewForEntryWithHeadline:@"Fortpflanzung" entry:self.currentAnimal.fortpflanzung startY:startY];
    [self.detailAnimalScrollView addSubview:fortpflanzungView];

    startY += fortpflanzungView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *feindeView = [self createViewForEntryWithHeadline:@"Feinde" entry:self.currentAnimal.feinde startY:startY];
    [self.detailAnimalScrollView addSubview:feindeView];

    startY += feindeView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *nahrungView = [self createViewForEntryWithHeadline:@"Nahrung" entry:self.currentAnimal.nahrung startY:startY];
    [self.detailAnimalScrollView addSubview:nahrungView];
    
    startY += nahrungView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    UIView *bedrohungsstatusView = [self createViewForEntryWithHeadline:@"Bedrohungsstatus" entry:self.currentAnimal.bedrohungsstatus startY:startY];
    [self.detailAnimalScrollView addSubview:bedrohungsstatusView];
   
    startY += bedrohungsstatusView.frame.size.height+GAP_BETWEEN_ENTRIES;
    
    self.detailAnimalScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, startY);
    [self.view addSubview:self.detailAnimalScrollView];
    
}

- (UIView*)createViewForEntryWithHeadline:(NSString*)headline entry:(NSString*)entry startY:(CGFloat)h {
    
    UIView *view = [UIView new];
    
    UILabel *headlineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, LABELWIDTH, HEADING_LABEL_HEIGHT)];
    headlineLabel.text = headline;
    headlineLabel.textColor = [UIColor blackColor];
    headlineLabel.font = [UIFont boldSystemFontOfSize:18];
    headlineLabel.backgroundColor = [UIColor clearColor];
    
    UILabel *entryLabel = [UILabel new];
    entryLabel.numberOfLines = 2000;
    entryLabel.text = entry;
    entryLabel.textColor = [UIColor blackColor];
    entryLabel.font = [UIFont systemFontOfSize:18];
   // entryLabel.textColor = Colors.darkGreenColor;
    entryLabel.backgroundColor = [UIColor clearColor];
    CGSize expSize = [entryLabel.text sizeWithFont:entryLabel.font constrainedToSize:CGSizeMake(LABELWIDTH, 3000) lineBreakMode:UILineBreakModeWordWrap];
    entryLabel.frame = CGRectMake(0, HEADING_LABEL_HEIGHT, LABELWIDTH, expSize.height);
    
    [view addSubview:headlineLabel];
    [view addSubview:entryLabel];
    
    view.frame = CGRectMake(10, h, LABELWIDTH, HEADING_LABEL_HEIGHT+expSize.height);

    return view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setDetailAnimalScrollView:nil];
    [super viewDidUnload];
}

#pragma mark - Segues
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showAnimalOnMap"]) {
        AnimalMapViewController *controller = segue.destinationViewController;
        controller.currentAnimal = self.currentAnimal;
        return;
    }
    
}
@end
