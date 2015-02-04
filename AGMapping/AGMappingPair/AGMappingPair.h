//
//  AGMappingPair.h
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGMappingPair : NSObject

@property (nonatomic, strong) NSString* keyPathFrom;
@property (nonatomic, strong) NSString* keyTo;

+ (instancetype) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                      keyTo:(NSString*) keyTo;

- (void) mapValueFromJSONObject:(NSDictionary*) jsonObject
                       toObject:(NSObject*) object;

@end
