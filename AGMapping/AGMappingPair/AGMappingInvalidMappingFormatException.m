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

#import "AGMappingInvalidMappingFormatException.h"

@implementation AGMappingInvalidMappingFormatException

+ (instancetype) exception {
    return [self exceptionWithReason:@"Exception while using mapping of class %@. All JSON keyPathFrom-s must be of NSString class. All JSON keyTo-s must be of NSString or NSArray<NSString> class."];
}

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                     keyPathFrom:(id) keyPathFrom {
    NSString* objectClassName = NSStringFromClass(objectClass);
    NSString* keyFromClassName = NSStringFromClass([keyPathFrom class]);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Exception while using mapping of class %@. All JSON keyPathFrom-s must be of NSString class. Key %@ is of %@ class",
             NSStringFromClass(objectClass),
             keyPathFrom,
             keyFromClassName]
                            userInfo:@{@"objectClassName":  objectClassName,
                                       @"keyFromClassName": keyFromClassName}];
}

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                           keyTo:(id) keyTo {
    NSString* objectClassName = NSStringFromClass(objectClass);
    NSString* keyToClassName = NSStringFromClass([keyTo class]);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Exception while using mapping of class %@. All JSON keyTo-s must be of NSString or NSArray<NSString> class. Key %@ is of %@ class",
             NSStringFromClass(objectClass),
             keyTo,
             keyToClassName]
                            userInfo:@{@"objectClassName":  objectClassName,
                                       @"keyToClassName": keyToClassName}];
}

+ (instancetype) exceptionWithMappingObjectClass:(Class) objectClass
                                      keyToEntry:(id) keyToEntry {
    NSString* objectClassName = NSStringFromClass(objectClass);
    NSString* keyToEntryClassName = NSStringFromClass([keyToEntry class]);
    
    return [self exceptionWithReason:
            [NSString stringWithFormat:@"Exception while using mapping of class %@. All JSON keysTo-s entries must be of NSString. Entry %@ is of %@ class",
             NSStringFromClass(objectClass),
             keyToEntry,
             keyToEntryClassName]
                            userInfo:@{@"objectClassName":      objectClassName,
                                       @"keyToEntryClassName":  keyToEntryClassName}];
}

@end
