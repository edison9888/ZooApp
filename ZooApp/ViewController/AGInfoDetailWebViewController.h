//
//  AGInfoDetailWebViewController.h
//  ZooApp
//
//  Created by Andrea Gerlach on 25.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AGInfoDetailWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *infoWebView;
@property (nonatomic, strong) NSString *htmlName;

@end
