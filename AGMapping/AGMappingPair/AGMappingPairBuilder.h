//
//  AGMappingPairBuilder.h
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AGMappingPair;

@interface AGMappingPairBuilder : NSObject

@property (nonatomic, strong) NSDictionary* typesOfProperties;

- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo;

- (AGMappingPair*) mappingPairWithKeyPathFrom:(NSString*) keyPathFrom
                                        keyTo:(NSString*) keyTo
                                         info:(NSString*) info;

@end
