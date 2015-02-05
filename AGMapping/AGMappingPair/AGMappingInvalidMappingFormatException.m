//
//  AGMappingInvalidMappingFormatException.m
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingInvalidMappingFormatException.h"

@implementation AGMappingInvalidMappingFormatException

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                     keyPathFrom:(id) keyPathFrom {
    NSString* objectClassName = NSStringFromClass(objectClass);
    NSString* keyFromClassName = NSStringFromClass([keyPathFrom class]);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Exception while using mapping of class %@. All JSON keyPathFrom-s must be of NSString class. Key %@ is of %@ class",
             NSStringFromClass(objectClass),
             keyPathFrom,
             keyFromClassName]
                            userInfo:@{@"objectClassName":  objectClassName,
                                       @"keyFromClassName": keyFromClassName}];
}

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                           keyTo:(id) keyTo {
    NSString* objectClassName = NSStringFromClass(objectClass);
    NSString* keyToClassName = NSStringFromClass([keyTo class]);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Exception while using mapping of class %@. All JSON keyTo-s must be of NSString or NSArray<NSString> class. Key %@ is of %@ class",
             NSStringFromClass(objectClass),
             keyTo,
             keyToClassName]
                            userInfo:@{@"objectClassName":  objectClassName,
                                       @"keyToClassName": keyToClassName}];
}

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                      keyToEntry:(id) keyToEntry {
    NSString* objectClassName = NSStringFromClass(objectClass);
    NSString* keyToEntryClassName = NSStringFromClass([keyToEntry class]);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Exception while using mapping of class %@. All JSON keysTo-s entries must be of NSString. Entry %@ is of %@ class",
             NSStringFromClass(objectClass),
             keyToEntry,
             keyToEntryClassName]
                            userInfo:@{@"objectClassName":      objectClassName,
                                       @"keyToEntryClassName":  keyToEntryClassName}];
}

@end
