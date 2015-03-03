//
//  AGMyClass.m
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMyClass.h"
#import "AGMappingProtocol.h"

@interface AGMyClass () <AGMappingProtocol>

@end

@implementation AGMyClass
+ (NSDictionary *) mappingFromJSONToObject {
    return @{
                 @"string": @"string",
                 @"number": @"number"
            };
}
@end
