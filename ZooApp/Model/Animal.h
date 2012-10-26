//
//  Animal.h
//  ZooApp
//
//  Created by Andrea Gerlach on 18.10.12.
//  Copyright (c) 2012 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *latitude;
@property (nonatomic, strong) NSNumber *longitude;
@property (nonatomic, strong) NSString *area;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *verwandschaft;
@property (nonatomic, strong) NSString *lebensraum;
@property (nonatomic, strong) NSString *hoechstalter;
@property (nonatomic, strong) NSString *groesse;
@property (nonatomic, strong) NSString *gewicht;
@property (nonatomic, strong) NSString *sozialstruktur;
@property (nonatomic, strong) NSString *fortpflanzung;
@property (nonatomic, strong) NSString *feinde;
@property (nonatomic, strong) NSString *nahrung;
@property (nonatomic, strong) NSString *bedrohungsstatus;
@property (nonatomic, strong) NSString *image;

@end
