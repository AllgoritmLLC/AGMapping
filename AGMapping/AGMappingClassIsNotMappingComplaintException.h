//
//  AGMappingClassIsNotMappingComplaintException.h
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "VBException.h"

@interface AGMappingClassIsNotMappingComplaintException : VBException

+ (instancetype) exceptionWithClass:(Class)objectClass;
+ (instancetype) exceptionWithClassName:(NSString*) className;

@end
