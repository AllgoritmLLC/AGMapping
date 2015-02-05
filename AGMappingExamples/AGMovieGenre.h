//
//  AGMovieGenre.h
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AGMappingProtocol.h"

@interface AGMovieGenre : NSObject <AGMappingProtocol>

@property (nonatomic, strong) NSString* name;

@end
