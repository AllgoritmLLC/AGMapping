//
//  NSDictionary+JSONObject.m
//  Hailer
//
//  Created by Pavel Jaoshvili on 03/12/15.
//  Copyright © 2015 Allgoritm. All rights reserved.
//

#import "NSDictionary+JSONObject.h"

@implementation NSDictionary (JSONObject)

- (instancetype) initWithJSONObject:(NSDictionary*) jsonObject {
    return [self initWithDictionary:jsonObject];
}

@end
