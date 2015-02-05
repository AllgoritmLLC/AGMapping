//
//  AGPerson.h
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AGMappingProtocol.h"

@interface AGPerson : NSObject <AGMappingProtocol>

@property (nonatomic, strong) NSNumber* identifier;
@property (nonatomic, strong) NSString* name;

@property (nonatomic, strong) NSArray* castDates;

@end
