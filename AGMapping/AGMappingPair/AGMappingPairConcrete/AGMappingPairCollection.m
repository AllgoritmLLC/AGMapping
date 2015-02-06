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

#import "AGMappingPairCollection.h"

#import "AGMappingClassNameUndefinedException.h"

#import "AGMappingPairString.h"
#import "AGMappingPairNumber.h"
#import "AGMappingPairDate.h"

#import "NSObject+AGMapping.h"

@implementation AGMappingPairCollection

+ (instancetype) mappingPairWithKeyPathFrom:(NSString *)keyPathFrom
                                      keyTo:(NSString *)keyTo{
    @throw [AGMappingClassNameUndefinedException exception];
}

+ (instancetype) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                      keyTo:(NSString*) keyTo
                             entryClassName:(NSString*) entryClassName {
    return [self mappingPairWithKeyPathFrom:keyPathFrom
                                       keyTo:keyTo
                              entryClassName:entryClassName
                             entryClassInfo:nil];
}

+ (instancetype) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                      keyTo:(NSString*) keyTo
                             entryClassName:(NSString*) entryClassName
                             entryClassInfo:(NSString*) entryClassInfo{
    return [[self alloc] initWithKeyPathFrom:keyPathFrom
                                       keyTo:keyTo
                              entryClassName:entryClassName
                              entryClassInfo:entryClassInfo];
}

- (instancetype) initWithKeyPathFrom:(NSString*) keyPathFrom
                               keyTo:(NSString*) keyTo
                      entryClassName:(NSString*) entryClassName
                      entryClassInfo:(NSString*) entryClassInfo{
    self = [super initWithKeyPathFrom:keyPathFrom
                                keyTo:keyTo];
    if (self) {
        self.entryClassName = entryClassName;
        self.entryClassInfo = entryClassInfo;
    }
    return self;
}

- (Class) entryClass {
    return NSClassFromString(self.entryClassName);
}

+ (id) objectWithJSONValue:(id)jsonValue {
    return [self objectWithJSONValue:jsonValue
                          entryClass:[NSString class]
                      entryClassInfo:nil];
}
+ (id) objectWithJSONValue:(id)jsonValue
                entryClass:(Class)entryClass
            entryClassInfo:(NSString*)entryClassInfo {
    id obj = nil;
    if (entryClass == [NSString class]) {
        obj = [AGMappingPairString objectWithJSONValue:jsonValue];
        
    }else if (entryClass == [NSNumber class]) {
        obj = [AGMappingPairNumber objectWithJSONValue:jsonValue];
        
    }else if (entryClass == [NSDate class]) {
        if (entryClassInfo) {
            obj = [AGMappingPairDate objectWithJSONValue:jsonValue
                                              dateFormat:entryClassInfo];
        }else{
            obj = [AGMappingPairDate objectWithJSONValue:jsonValue];
        }
        
    }else{
        obj = [entryClass objectMappedFromJSONObject:jsonValue];
    }
    return obj;
}

@end
