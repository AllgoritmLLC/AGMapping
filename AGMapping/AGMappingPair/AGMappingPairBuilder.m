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

#import "AGMappingPairBuilder.h"

#import "AGMappingPairNumber.h"
#import "AGMappingPairString.h"
#import "AGMappingPairDate.h"
#import "AGMappingPairClass.h"
#import "AGMappingPairArray.h"

#import "AGMappingUndefinedObjectPropertyException.h"

@interface AGMappingPairBuilder ()

@property (nonatomic, strong) NSDictionary* typesOfProperties;

@end

@implementation AGMappingPairBuilder

- (void) setMappingObjectClass:(Class)mappingObjectClass {
    _mappingObjectClass = mappingObjectClass;
    
    id instance = [mappingObjectClass new];
    SEL action = @selector(typesOfProperties);
    IMP imp = [instance methodForSelector:action];
    NSDictionary* (*func)(id, SEL) = (void *)imp;
    
    self.typesOfProperties = func(instance, action);
}

#pragma mark - build
- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo {
    return [self mappingPairWithKeyPathFrom:keyPathFrom
                                      keyTo:keyTo
                                     params:nil];
}

- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo
                                       params:(NSArray*) params {
    
    NSString* keyToPropertyType = self.typesOfProperties[keyTo];
    if (keyToPropertyType == nil) {
        @throw [AGMappingUndefinedObjectPropertyException exceptionWithObjectClass:self.mappingObjectClass
                                                                      propertyName:keyTo];
    }
    
    AGMappingPair* pair = nil;
    if ([keyToPropertyType isEqualToString:@"NSString"]) {
        pair = [AGMappingPairString mappingPairWithKeyPathFrom:keyPathFrom
                                                         keyTo:keyTo];

    }else if ([keyToPropertyType isEqualToString:@"NSNumber"]) {
        pair = [AGMappingPairNumber mappingPairWithKeyPathFrom:keyPathFrom
                                                         keyTo:keyTo];

    }else if ([keyToPropertyType isEqualToString:@"NSDate"]) {
        pair = [AGMappingPairDate mappingPairWithKeyPathFrom:keyPathFrom
                                                       keyTo:keyTo];

    }else if ([keyToPropertyType isEqualToString:@"NSArray"]) {
        pair = [AGMappingPairArray mappingPairWithKeyPathFrom:keyPathFrom
                                                        keyTo:keyTo];
        
    }else {
        pair = [AGMappingPairClass mappingPairWithKeyPathFrom:keyPathFrom
                                                        keyTo:keyTo];
        
    }
    
    return pair;
}

@end
