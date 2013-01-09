//
//  AGAnimalDetailViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 08.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGAnimalDetailViewController.h"

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
    self.title = self.currentAnimal.name;
    self.title = @"Details";
    self.areaLabel.text = [NSString stringWithFormat:@"Themenwelt: %@", self.currentAnimal.area];
    [self setContentArray];

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
    [self setInfoScrollView:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
}

- (void)setContentArray {
    
    NSArray *contentArray = [NSArray arrayWithObjects:@"asdfg", @"wertzu", @"asdfg", @"wertzu", nil];
    
    for (int i = 0; i < contentArray.count; i++) {
//        GVSpecialsModel *special = [contentArray objectAtIndex:i];
        
        CGRect frame;
        frame.origin.x = self.infoScrollView.frame.size.width * i;
        frame.origin.y = 5.0f;
        frame.size = self.infoScrollView.frame.size;
       // frame.size.height -= 25.0f;
        
        UIView *contentView = [[UIView alloc] initWithFrame:frame];
        contentView.backgroundColor = [UIColor redColor];
      //  UILabel *test =
   //     [contentArray objectAtIndex:i];
     
       // [contentView addSubview:test];
      //  [contentView setContent:special];
        
        [self.infoScrollView addSubview:contentView];
    }
    
    self.infoScrollView.contentSize = CGSizeMake(self.infoScrollView.frame.size.width * contentArray.count, self.infoScrollView.frame.size.height);
    self.pageControl.numberOfPages = contentArray.count;
   // self.pageControl.
  //  self.control.smfWidth = contentArray.count * 25.0f + 20.0f;
  //  self.control.smfX = (self.infoScrollView.smfWidth - self.control.smfWidth)/2;
    
  //  [self.infoScrollView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(specialTapped:)]];
}


@end
