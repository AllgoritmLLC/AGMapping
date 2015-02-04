//
//  AGMappingPairBuilder.m
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingPairBuilder.h"

#import "AGMappingPair.h"

@implementation AGMappingPairBuilder

+ (instancetype) builderWithTypesOfProperties:(NSDictionary*) typesOfProperties {
    return [[self alloc] initWithTypesOfProperties:typesOfProperties];
}

- (instancetype) initWithTypesOfProperties:(NSDictionary*) typesOfProperties {
    self = [super init];
    if (self) {
        self.typesOfProperties = typesOfProperties;
    }
    return self;
}

#pragma mark - build
- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo {
    return nil;
}

- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo
                                         info:(NSString*) info {
    return nil;
}

@end
