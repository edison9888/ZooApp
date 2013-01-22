//
//  AGFavAnimal.h
//  ZooApp
//
//  Created by Andrea Gerlach on 22.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface AGFavAnimal : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * notificationIfClose;

@end
