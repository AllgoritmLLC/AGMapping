//
//  AGMappingClassIsNotMappingComplaintException.m
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingClassIsNotMappingComplaintException.h"

@implementation AGMappingClassIsNotMappingComplaintException

+ (instancetype) exception {
    return [self exceptionWithClassName:@""];
}

+ (instancetype) exceptionWithClass:(Class)objectClass {
    return [self exceptionWithClassName:NSStringFromClass(objectClass)];
}

+ (instancetype) exceptionWithClassName:(NSString*) className {
    return [self exceptionWithReason:[NSString stringWithFormat:@"Class %@ does not conform protocol AGMappingProtocol. To create object of this class from JSON using AGMapping, implement AGMappingProtocol.", className]
                            userInfo:@{@"className": className}];
}

@end
