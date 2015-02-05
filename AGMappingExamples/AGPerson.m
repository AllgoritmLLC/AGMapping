//
//  AGPerson.m
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import "AGPerson.h"

@implementation AGPerson

+ (NSDictionary *) mappingFromJSONToObject {
    return @{@"id":     @"identifier",
             @"name":   @"name",
             @"shotDates":  @[@"castDates", @"NSDate", @"yyyy/MM/dd"]};
}

@end
