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

#import "AGMappingPairArray.h"

#import "NSObject+AGMapping.h"

#import "AGMappingPairString.h"
#import "AGMappingPairNumber.h"
#import "AGMappingPairDate.h"

@implementation AGMappingPairArray

#pragma mark - mapping
- (void) mapValueFromJSONObject:(NSDictionary *) jsonObject
                       toObject:(NSObject *) object {
    
    NSArray* jsonValue = [jsonObject valueForKeyPath:self.keyPathFrom];
    if (jsonValue) {
        NSMutableArray* array = [NSMutableArray new];

        if ([jsonValue isKindOfClass:[NSArray class]] == NO) {
            jsonValue = [NSArray arrayWithObject:jsonValue];
        }
        
        for (NSInteger i = 0; i < jsonValue.count; i++) {
            id jsonValueEntry = jsonValue[i];
            NSObject* obj = [self.class objectWithJSONValue:jsonValueEntry
                                                 entryClass:self.entryClass
                                             entryClassInfo:self.entryClassInfo];            
                        
            if (obj) {
                [array addObject:obj];
            }
        }
        
        if (array.count == 0) {
            array = nil;
        }
        [object setValue:[NSArray arrayWithArray:array]
              forKeyPath:self.keyTo];
    }
}

@end
