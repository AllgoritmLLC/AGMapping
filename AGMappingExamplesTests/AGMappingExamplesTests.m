//
//  AGMappingExamplesTests.m
//  AGMappingExamplesTests
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AGMovie.h"
#import "AGMovieGenre.h"
#import "AGPerson.h"

#import "AGMapping.h"

#import "AGMappingManager.h"
#import "AGMappingPair.h"
#import "AGMappingPairDate.h"
#import "AGMappingPairCollection.h"

@interface AGMappingExamplesTests : XCTestCase

@end

@implementation AGMappingExamplesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testGoodJSON {
    
    NSMutableArray* jsonObjects = [NSMutableArray new];
    
    [jsonObjects addObject:@{@"id":         @(123),
                             @"poster":     @{@"poster_small":    @"url for poster_small",
                                            @"poster_big":      @"url for poster_big"},
                             @"genre":      @{@"name": @"comedy"},
                             @"cast":       @[@{@"id":      @(100500),
                                                @"name":    @"John",
                                                @"shotDates": @[@"2011/11/11", @"2012/12/12"]},
                                            @{@"id":      @(100501),
                                                @"name":    @"Victoria"}],
                             @"date":       @"2010/01/01",
                             @"countries":  @[@"Russia", @"USA"]}];
    
    [jsonObjects addObject:@{@"id":         @(123),
                             @"poster":     @{@"poster_small":    @"url for poster_small",
                                              @"poster_big":      @"url for poster_big"},
                             @"genre":      @{@"name": @"comedy"},
                             @"cast":       @[@{@"id":      @(100500),
                                                @"name":    @"John",
                                                @"shotDates": @[@"2011/11/11", @"2012/12/12"]},
                                              @{@"id":      @(100501),
                                                @"name":    @"Victoria"}],
                             @"date":       @"2010/01/01",
                             @"countries":  @"Russia"}];

    for (NSDictionary* json in jsonObjects) {
        AGMovie* movie = nil;
        XCTAssertNoThrow(movie = [AGMovie objectMappedFromJSONObject:json]);
        
        [self checkMappingOfJSONObject:json
                               toMovie:movie];
    }
    
    XCTAssert(YES, @"Pass");
}

- (void) checkMappingOfJSONObject:(NSDictionary*) json
                          toMovie:(AGMovie*) movie{
//    @property (nonatomic, strong) NSNumber* identifier;
//    @property (nonatomic, strong) NSString* urlSmall;
//    @property (nonatomic, strong) AGMovieGenre* genre;
//    @property (nonatomic, strong) NSArray* cast;
//    @property (nonatomic, strong) NSDate* releaseDate;
//    @property (nonatomic, strong) NSArray* countries;
    
    XCTAssertEqual(movie.identifier, json[@"id"]);
    XCTAssertEqual(movie.urlSmall, json[@"poster"][@"poster_small"]);
    
    [self checkMappingOfJSONObject:json[@"genre"]
                           toGenre:movie.genre];
    
    for (NSInteger i = 0; i < [json[@"cast"] count]; i++) {
        NSDictionary* personJSON = json[@"cast"][i];
        [self checkMappingOfJSONObject:personJSON
                              toPerson:movie.cast[i]];
    }
    
    [self checkMappingOfJSONDate:json[@"date"]
                      withFormat:[self mappingDateFormatForClass:[AGMovie class]
                                                           keyTo:@"releaseDate"]
                          toDate:movie.releaseDate];
    
    for (NSInteger i = 0; i < [json[@"country"] count]; i++) {
        XCTAssertEqual(json[@"country"][i], movie.countries[i]);
    }
}

- (void) checkMappingOfJSONObject:(NSDictionary*) json
                          toGenre:(AGMovieGenre*) genre{
//    @property (nonatomic, strong) NSString* name;
    
    XCTAssertEqual(genre.name, json[@"name"]);
}

- (void) checkMappingOfJSONObject:(NSDictionary*) json
                         toPerson:(AGPerson*) person{
//    @property (nonatomic, strong) NSNumber* identifier;
//    @property (nonatomic, strong) NSString* name;
//    
//    @property (nonatomic, strong) NSArray* castDates;
    XCTAssertEqual(person.identifier, json[@"id"]);
    XCTAssertEqual(person.name, json[@"name"]);

    for (NSInteger i = 0; i < [json[@"shotDates"] count]; i++) {
        [self checkMappingOfJSONDate:json[@"shotDates"][i]
                          withFormat:[self mappingDateFormatForClass:[AGPerson class]
                                                               keyTo:@"castDates"]
                              toDate:person.castDates[i]];
    }
}

- (void) checkMappingOfJSONDate:(NSString*) jsonDate
                     withFormat:(NSString*) dateFormat
                         toDate:(NSDate*) date {
    
    NSDate* dateLocal = nil;
    if (dateFormat) {
        static NSDateFormatter* __dateFormatter = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __dateFormatter = [NSDateFormatter new];
        });
        __dateFormatter.dateFormat = dateFormat;
        dateLocal = [__dateFormatter dateFromString:jsonDate];
    }else{
        dateLocal = [NSDate dateWithTimeIntervalSince1970:[jsonDate doubleValue]];
    }
    
    XCTAssert([dateLocal isEqualToDate:date]);
}

- (NSString*) mappingDateFormatForClass:(Class) targetClass
                                  keyTo:(NSString*) keyTo {
    AGMappingPair* pair = [self mappingPairForClass:targetClass
                                              keyTo:keyTo];
    if ([pair isKindOfClass:[AGMappingPairDate class]]) {
        return ((AGMappingPairDate*)pair).dateFormat;
    }else if ([pair isKindOfClass:[AGMappingPairCollection class]]) {
        return ((AGMappingPairCollection*)pair).entryClassInfo;
    }
    return nil;
}

- (AGMappingPair*) mappingPairForClass:(Class)targetClass
                                 keyTo:(NSString*)keyTo {
    return [[[[AGMappingManager sharedInstance] mappingPairsForClass:targetClass]
             filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"keyTo == %@", keyTo]]
            lastObject];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
