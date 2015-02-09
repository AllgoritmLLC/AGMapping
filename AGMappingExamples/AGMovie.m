//
//  AGMovie.m
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGMovie.h"

@implementation AGMovie

+ (NSDictionary *) mappingFromJSONToObject {
    return @{@"id":                     @"identifier",
             @"poster.poster_small":    @"urlSmall",
             @"genre":                  @"genre",
             @"cast":                   @{kAGMappingToKey:          @"cast",
                                          kAGMappingClassNameKey:   @"AGPerson"},
             @"date":                   @{kAGMappingToKey:          @"releaseDate",
                                          kAGMappingDateFormatKey:  @"yyyy/MM/dd"},
             @"countries":              @{kAGMappingToKey:          @"countries",
                                          kAGMappingClassNameKey:   @"NSString"}};
}

@end
