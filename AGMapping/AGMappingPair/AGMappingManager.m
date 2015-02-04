//
//  AGMappingManager.m
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMappingManager.h"

@interface AGMappingManager ()

@property (nonatomic, strong) NSMutableDictionary* mappingByClassName;

@end

@implementation AGMappingManager

+ (instancetype) sharedInstance {
    static AGMappingManager* __instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __instance = [AGMappingManager new];
    });
    return __instance;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        self.mappingByClassName = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - mapping
- (NSArray*) mappingForClass:(Class)objectClass {
    
    NSArray* mapping = self.mappingByClassName[NSStringFromClass(objectClass)];

    if (mapping == nil) {
        mapping = [self createMappingForClass:objectClass];
    }
    
    return mapping;
}

- (NSArray*) createMappingForClass:(Class)objectClass {
    return nil;
}

@end
