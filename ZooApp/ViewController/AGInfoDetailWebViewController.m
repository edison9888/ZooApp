//
//  AGInfoDetailWebViewController.m
//  ZooApp
//
//  Created by Andrea Gerlach on 25.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "AGInfoDetailWebViewController.h"

@interface AGInfoDetailWebViewController ()

@end

@implementation AGInfoDetailWebViewController

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
    [self.infoWebView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:self.htmlName ofType:@"html"] isDirectory:NO]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setInfoWebView:nil];
    [super viewDidUnload];
}
@end
