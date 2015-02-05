//
//  AGMovie.h
//  AGMappingExamples
//
//  Created by develop on 05/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AGMapping.h"

@class AGMovieGenre;

@interface AGMovie : NSObject <AGMappingProtocol>

@property (nonatomic, strong) NSNumber* identifier;
@property (nonatomic, strong) NSString* urlSmall;
@property (nonatomic, strong) AGMovieGenre* genre;
@property (nonatomic, strong) NSArray* cast;
@property (nonatomic, strong) NSDate* releaseDate;
@property (nonatomic, strong) NSArray* countries;

@end
