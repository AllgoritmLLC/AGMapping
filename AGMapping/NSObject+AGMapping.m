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

#import "NSObject+AGMapping.h"

#import <objc/runtime.h>

@implementation NSObject (AGMapping)

#pragma mark - properties
- (NSDictionary*) typesOfProperties {
    
    NSMutableDictionary* dictTypes = [NSMutableDictionary dictionary];
    
    unsigned int propCount;
    objc_property_t *properties = class_copyPropertyList(self.class, &propCount);
    
    for (NSUInteger i = 0; i < propCount; i++) {
        objc_property_t prop = properties[i];
        NSString* propName = [NSString stringWithUTF8String:property_getName(prop)];
        propName = [self stringByRemovingTrash:propName];
        
        unsigned int attrCount;
        objc_property_attribute_t *attributes = property_copyAttributeList(prop, &attrCount);
        
        for (NSInteger j = 0; j < attrCount; j++) {
            objc_property_attribute_t attr = attributes[j];
            NSString* attrName = [NSString stringWithUTF8String:attr.name];
            NSString* attrValue = [NSString stringWithUTF8String:attr.value];
            
            if ([attrName isEqualToString:@"T"] && attrValue.length) {
                attrValue = [self stringByRemovingTrash:attrValue];
                dictTypes[propName] = attrValue;
                break;
            }
        }
        free(attributes);
    }
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dictTypes];
}

- (NSString*) stringByRemovingTrash:(NSString*)string {
    if (string.length) {
        return [string stringByReplacingOccurrencesOfString:@"\\W*(\\w*)\\W*"
                                                 withString:@"$1"
                                                    options:NSRegularExpressionSearch
                                                      range:NSMakeRange(0, string.length)];
    }else{
        return @"";
    }
}

@end
