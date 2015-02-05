//
//  AGMappingInvalidMappingFormatException.h
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "VBException.h"

@interface AGMappingInvalidMappingFormatException : VBException

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                     keyPathFrom:(id) keyPathFrom;

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                           keyTo:(id) keyTo;

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                      keyToEntry:(id) keyToEntry;

@end
