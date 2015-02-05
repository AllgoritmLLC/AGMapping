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

#import "AGMappingClassIsNotMappingComplaintException.h"

#import "AGMappingProtocol.h"

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
    id instance = [objectClass new];
    if ([instance conformsToProtocol:@protocol(AGMappingProtocol)] == NO) {
        @throw [AGMappingClassIsNotMappingComplaintException exceptionWithClass:objectClass];
    }
    
    
}

@end
