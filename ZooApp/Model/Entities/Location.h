//
//  Location.h
//  ZooApp
//
//  Created by Andrea Gerlach on 06.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import <MapKit/MapKit.h>

@class ZooItem;

@interface Location : NSManagedObject <MKAnnotation>

@property (nonatomic, retain) NSString * area;
@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * icon;
@property (nonatomic, retain) ZooItem *zooItem;

@end
