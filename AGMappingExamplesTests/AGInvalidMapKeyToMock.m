//
//  AGInvalidMapKeyToMock.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGInvalidMapKeyToMock.h"
#import "AGMappingProtocol.h"

@implementation AGInvalidMapKeyToMock
+ (NSDictionary *) mappingFromJSONToObject {
    return @{
             @"string":     @(123),
             @"number":     @"number",
             @"array":      @{kAGMappingToKey:          @"array",
                              kAGMappingClassNameKey:   @"NSNumber"},
             @"objInner":   @"objInner",
             @"date":       @"date"
             
             };
}
@end
