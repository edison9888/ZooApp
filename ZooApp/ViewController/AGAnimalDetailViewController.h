//
//  AGAnimalDetailViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 08.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGAnimal.h"

@interface AGAnimalDetailViewController : UIViewController <UIScrollViewDelegate, UIPageViewControllerDelegate>

// UI
@property (weak, nonatomic) IBOutlet UIImageView *animalImageView;
@property (weak, nonatomic) IBOutlet UILabel *animalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *enclosureLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *directionLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *chalkboardScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *chalkboardPageControl;
@property (weak, nonatomic) IBOutlet UILabel *feedingLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentaryLabel;

@property (weak, nonatomic) IBOutlet UIButton *favAnimalButton;
@property (weak, nonatomic) IBOutlet UIButton *favFeedingButton;
@property (weak, nonatomic) IBOutlet UIButton *favCommentaryButton;
@property (weak, nonatomic) IBOutlet UITextView *funFactTextView;


// MODEL
@property (nonatomic, strong) AGAnimal *currentAnimal;


@property (assign) BOOL favAnimal;
@property (assign) BOOL favFeedingTime;
@property (assign) BOOL favCommentaryTime;


- (IBAction)pageChanged:(id)sender;
- (IBAction)favAnimalButtonPressed:(id)sender;
- (IBAction)favFeedingButtonPressed:(id)sender;
- (IBAction)favCommentaryButtonPressed:(id)sender;


@end
