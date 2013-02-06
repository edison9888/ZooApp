//
//  AnimalFilterViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 24.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGAnimalFilterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) NSString *areaFilterString;
@property (nonatomic, strong) NSString *catFilterString;

@property (strong, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UIButton *mammalsButton;
@property (weak, nonatomic) IBOutlet UIButton *birdsButton;
@property (weak, nonatomic) IBOutlet UIButton *reptilesButton;
@property (weak, nonatomic) IBOutlet UIButton *amphibiansButton;
@property (weak, nonatomic) IBOutlet UIButton *invertebratesButton;
@property (weak, nonatomic) IBOutlet UIButton *fishButton;

@property (weak, nonatomic) IBOutlet UIButton *foundersGardenButton;
@property (weak, nonatomic) IBOutlet UIButton *gondwanaland;
@property (weak, nonatomic) IBOutlet UIButton *asiaButton;
@property (weak, nonatomic) IBOutlet UIButton *pongolandButton;
@property (weak, nonatomic) IBOutlet UIButton *africaButton;
@property (weak, nonatomic) IBOutlet UIButton *southAmericaButton;


@property (nonatomic, strong) UIBarButtonItem *barButtonItemDone;
- (IBAction)filterButtonPressed:(id)sender;


@end
