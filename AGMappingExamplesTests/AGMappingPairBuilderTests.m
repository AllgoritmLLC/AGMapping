//
//  AGMappingPairBuilderTests.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMappingPairBuilder.h"
#import "AGMock.h"

#import "AGMappingPairString.h"
#import "AGMappingPairArray.h"
#import "AGMappingPairNumber.h"
#import "AGMappingPairDate.h"
#import "AGMappingPairObject.h"
#import "AGMappingProtocol.h"


@interface AGMappingPairBuilderTests : XCTestCase

@end

@implementation AGMappingPairBuilderTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItSetsMappingObjectClassAndTypesOfPropierties {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMock class];
    NSDictionary *typesOfProperties = [mpb valueForKeyPath:@"typesOfProperties"];
    
    XCTAssertTrue([typesOfProperties[@"number"] isEqualToString:@"NSNumber"]);
    XCTAssertTrue([typesOfProperties[@"string"] isEqualToString:@"NSString"]);
    XCTAssertTrue([typesOfProperties[@"date"] isEqualToString:@"NSDate"]);
    XCTAssertTrue([typesOfProperties[@"objInner"] isEqualToString:@"AGMock"]);
    XCTAssertTrue([typesOfProperties[@"array"] isEqualToString:@"NSArray"]);
}

- (void)testThatItCreatesStringPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMock class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string" keyTo:@"string"];
    XCTAssertEqual(pair.keyTo, @"string");
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertTrue([pair isKindOfClass:[AGMappingPairString class]]);
}

- (void)testThatItCreatesArrayPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMock class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"array"
                                                   params:@{
                                                            kAGMappingClassNameKey: @"NSNumber"
                                                            }];
    XCTAssertTrue([pair isKindOfClass:[AGMappingPairArray class]]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"array");
    XCTAssertEqual(((AGMappingPairArray *)pair).entryClassName, @"NSNumber");
}

- (void)testThatItCreatesNumberPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMock class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"number"];
    XCTAssertTrue([pair isKindOfClass:[AGMappingPairNumber class]]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"number");
}

- (void)testThatItCreatesDatePairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMock class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"date"
                                                   params:@{
                                                            kAGMappingDateFormatKey:@"yyyy"
                                                            }];
    XCTAssertTrue([pair isKindOfClass:[AGMappingPairDate class]]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"date");
    XCTAssertEqual(((AGMappingPairDate *)pair).dateFormat, @"yyyy");
}

- (void)testThatItCreatesObjectPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMock class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"objInner"];
    XCTAssertTrue([pair isKindOfClass:[AGMappingPairObject class]]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"objInner");
}
@end
