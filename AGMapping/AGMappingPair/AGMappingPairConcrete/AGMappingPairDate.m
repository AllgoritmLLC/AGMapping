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

#import "AGMappingPairDate.h"

@implementation AGMappingPairDate

+ (instancetype) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                      keyTo:(NSString*) keyTo
                                 dateFormat:(NSString*) dateFormat {
    return [[self alloc] initWithKeyPathFrom:keyPathFrom
                                       keyTo:keyTo
                                   dateFormat:dateFormat];
}

- (instancetype) initWithKeyPathFrom:(NSString*) keyPathFrom
                               keyTo:(NSString*) keyTo
                          dateFormat:(NSString*) dateFormat {
    self = [super initWithKeyPathFrom:keyPathFrom
                                keyTo:keyTo];
    if (self) {
        self.dateFormat = dateFormat;
    }
    return self;
}

#pragma mark - mapping
- (void) mapValueFromJSONObject:(NSDictionary *) jsonObject
                       toObject:(NSObject *) object {
    
    id valueJSON = [jsonObject valueForKeyPath:self.keyPathFrom];
    if (valueJSON) {
        NSDate* date = nil;
        if ([valueJSON isKindOfClass:[NSNumber class]]) {
            date = [NSDate dateWithTimeIntervalSince1970:[valueJSON doubleValue]];
            
        }else if ([valueJSON isKindOfClass:[NSString class]]) {
            static NSDateFormatter* __dateFormatter = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                __dateFormatter = [NSDateFormatter new];
            });
            if (self.dateFormat) {
                __dateFormatter.dateFormat = self.dateFormat;
            }
            date = [__dateFormatter dateFromString:valueJSON];
        }
        
        if (date) {
            [object setValue:date
                  forKeyPath:self.keyTo];
        }
    }
}

@end
