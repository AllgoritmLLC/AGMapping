//
//  AGMappingUnknownObjectPropertyException.m
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingUndefinedObjectPropertyException.h"

@implementation AGMappingUndefinedObjectPropertyException

+ (instancetype) exceptionWithObjectClass:(Class) objectClass
                             propertyName:(NSString*) propertyName {
    NSString* objectClassName = NSStringFromClass(objectClass);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Property %@ of objectClass %@ is not undefined",
             NSStringFromClass(objectClass),
             propertyName]
                            userInfo:@{@"objectClassName":  objectClassName,
                                       @"propertyName":     propertyName}];
}

@end
