//
//  AGMyClass.m
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMock.h"
#import "AGMappingProtocol.h"

@interface AGMock () <AGMappingProtocol>

@end

@implementation AGMock
+ (NSDictionary *) mappingFromJSONToObject {
    return @{
                 @"string":     @"string",
                 @"number":     @"number",
                 @"array":      @{kAGMappingToKey:          @"array",
                                  kAGMappingClassNameKey:   @"NSNumber"},
                 @"objInner":   @"objInner",
                 @"date":       @"date"
                 
             };
}
@end
