//
//    The MIT License (MIT)
//
//    Copyright (c) 2015 Allgoritm LLC
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.
//

#import "AGMappingManager.h"

#import "NSObject+AGMapping.h"
#import "AGMappingProtocol.h"

#import "AGMappingClassIsNotMappingComplaintException.h"
#import "AGMappingInvalidMappingFormatException.h"

#import "AGMappingPairBuilder.h"

@interface AGMappingManager ()

@property (nonatomic, strong) NSMutableDictionary* mappingPairsByClassName;

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
        self.mappingPairsByClassName = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - mapping
- (NSArray*) mappingPairsForClass:(Class)objectClass {
    
    NSArray* mapping = self.mappingPairsByClassName[NSStringFromClass(objectClass)];

    if (mapping == nil) {
        mapping = [self createMappingPairsForClass:objectClass];
    }
    
    return mapping;
}

- (NSArray*) createMappingPairsForClass:(Class)objectClass {
    if ([objectClass conformsToProtocol:@protocol(AGMappingProtocol)] == NO) {
        @throw [AGMappingClassIsNotMappingComplaintException exceptionWithClass:objectClass];
    }
    
    AGMappingPairBuilder* builder = [AGMappingPairBuilder new];
    builder.mappingObjectClass = objectClass;
    
    NSDictionary* dictMapping = [objectClass mappingFromJSONToObject];
    [self validateMappingOfClass:objectClass
                  withDictionary:dictMapping];
    
    NSMutableArray* mappingPairs = [NSMutableArray new];
    for (NSString* keyFrom in dictMapping) {
        id keyTo = dictMapping[keyFrom];
        AGMappingPair* pair = nil;

        if ([keyTo isKindOfClass:[NSString class]]) {
            pair = [builder mappingPairWithKeyPathFrom:keyFrom
                                                 keyTo:keyTo];

        }else if ([keyTo isKindOfClass:[NSDictionary class]]) {
            pair = [builder mappingPairWithKeyPathFrom:keyFrom
                                                 keyTo:keyTo[kAGMappingToKey]
                                                params:keyTo];
        }
        
        if (pair) {
            [mappingPairs addObject:pair];
        }
    }
    
    self.mappingPairsByClassName[NSStringFromClass(objectClass)] = [NSArray arrayWithArray:mappingPairs];
    
    return self.mappingPairsByClassName[NSStringFromClass(objectClass)];
}

- (void) validateMappingOfClass:(Class)objectClass
                 withDictionary:(NSDictionary*) dictMapping {
    for (id keyPathFrom in dictMapping) {
        if ([keyPathFrom isKindOfClass:[NSString class]] == NO) {
            @throw [AGMappingInvalidMappingFormatException exceptionWithMappingObjectClass:objectClass
                                                                               keyPathFrom:keyPathFrom];
        }
        
        id keyTo = dictMapping[keyPathFrom];
        if ([keyTo isKindOfClass:[NSString class]] == NO &&
            [keyTo isKindOfClass:[NSDictionary class]] == NO) {
            @throw [AGMappingInvalidMappingFormatException exceptionWithMappingObjectClass:objectClass
                                                                                     keyTo:keyTo];
        }
        
        if ([keyTo isKindOfClass:[NSDictionary class]]) {
            NSDictionary* keyToDict = (NSDictionary*)keyTo;
            for (id keyToEntry in keyToDict.allKeys) {
                id value = keyToDict[keyToEntry];
                if ([keyToEntry isKindOfClass:[NSString class]] == NO || [value isKindOfClass:[NSString class]] == NO) {
                    @throw [AGMappingInvalidMappingFormatException exceptionWithMappingObjectClass:objectClass
                                                                                        keyToEntry:keyToEntry];
                }
            }
        }
    }
}

@end
