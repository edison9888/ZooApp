//
//  NSString+Sorting.m
//  ZooApp
//
//  Created by Andrea Gerlach on 03.02.13.
//  Copyright (c) 2013 de.andreagerlach. All rights reserved.
//

#import "NSString+Sorting.h"

@implementation NSString (Sorting)
- (NSString *)stringGroupByFirstInitial {
    if (!self.length || self.length == 1)
        return self;
    return [self substringToIndex:1];
}
@end