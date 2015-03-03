//
//  AGMappingTestsHelper.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingTestsHelper.h"

@implementation AGMappingTestsHelper

+(BOOL) array:(NSArray *)array containsObjectOfClass:(Class)aClass{
    for(id item in array){
        if([item isKindOfClass:aClass]){
            return YES;
        }
    }
    return NO;
};

@end
