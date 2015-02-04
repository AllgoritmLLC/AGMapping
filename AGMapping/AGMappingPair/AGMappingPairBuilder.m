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

@implementation AGMappingPairBuilder

+ (instancetype) builderWithTypesOfProperties:(NSDictionary*) typesOfProperties {
    return [[self alloc] initWithTypesOfProperties:typesOfProperties];
}

- (instancetype) initWithTypesOfProperties:(NSDictionary*) typesOfProperties {
    self = [super init];
    if (self) {
        self.typesOfProperties = typesOfProperties;
    }
    return self;
}

#pragma mark - build
- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo {
    return nil;
}

- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo
                                         info:(NSString*) info {
    return nil;
}

@end