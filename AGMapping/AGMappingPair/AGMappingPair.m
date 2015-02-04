//
//  AGMappingPair.m
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingPair.h"

@implementation AGMappingPair

+ (instancetype) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                      keyTo:(NSString*) keyTo {
    return [[self alloc] initWithKeyPathFrom:keyPathFrom
                                       keyTo:keyTo];
}

- (instancetype) initWithKeyPathFrom:(NSString*) keyPathFrom
                               keyTo:(NSString*) keyTo {
    self = [super init];
    if (self) {
        self.keyPathFrom = keyPathFrom;
        self.keyTo = keyTo;
    }
    return self;
}

- (void) mapValueFromJSONObject:(NSDictionary*) jsonObject
                       toObject:(NSObject*) object {

    [object setValue:[jsonObject valueForKeyPath:self.keyPathFrom]
          forKeyPath:self.keyTo];
}

@end
