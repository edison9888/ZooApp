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
@property (nonatomic, strong) NSMutableArray *catFilter;
@property (nonatomic, strong) NSMutableArray *areaFilter;
@property (strong, nonatomic) id delegate;

@property (nonatomic, strong) UIBarButtonItem *barButtonItemDone;
- (IBAction)filterButtonPressed:(id)sender;


@end
