//
//  AGMappingClassNameUndefinedException.m
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingClassNameUndefinedException.h"

@implementation AGMappingClassNameUndefinedException

+ (instancetype) exception {
    return [self exceptionWithReason:[NSString stringWithFormat:@"Entry class name is undefined"]];
}

@end
