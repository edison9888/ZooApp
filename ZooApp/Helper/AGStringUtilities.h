//
//  AGStringUtilities.h
//  ZooApp
//
//  Created by Andrea Gerlach on 15.01.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGStringUtilities : NSObject

/*
 Returns a string in the form of "1.3 km" etc, using miles (mi) or kilometers (km)
 and different decimal separators depending on the user locale.
 */
+ (NSString*) localizedDistanceFromMeters:(CGFloat)meters;


@end
