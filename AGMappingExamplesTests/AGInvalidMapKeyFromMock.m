//
//  AGInvalidKeyFromMock.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGInvalidMapKeyFromMock.h"
#import "AGMappingProtocol.h"

@implementation AGInvalidMapKeyFromMock
+ (NSDictionary *) mappingFromJSONToObject {
    return @{
             @(123):     @"string",
             @"number":     @"number",
             @"array":      @{kAGMappingToKey:          @"array",
                              kAGMappingClassNameKey:   @"NSNumber"},
             @"objInner":   @"objInner",
             @"date":       @"date"
             
             };
}
@end
