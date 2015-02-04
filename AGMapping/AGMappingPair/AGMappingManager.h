//
//  AGMappingManager.h
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGMappingManager : NSObject

+ (instancetype) sharedInstance;

- (NSArray*) mappingForClass:(Class)objectClass;

@end
