//
//  AGMappableObject.h
//  AGMappingExamples
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AGMappableObject <NSObject>

+ (NSDictionary*) mappingFromJSONToObject;

@end
