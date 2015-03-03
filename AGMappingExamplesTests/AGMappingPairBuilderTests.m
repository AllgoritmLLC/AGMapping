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
#import "AGMyClass.h"
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
    mpb.mappingObjectClass = [AGMyClass class];
    NSDictionary *typesOfProperties = [mpb valueForKeyPath:@"typesOfProperties"];
    
    XCTAssertTrue([typesOfProperties[@"number"] isEqualToString:@"NSNumber"]);
    XCTAssertTrue([typesOfProperties[@"string"] isEqualToString:@"NSString"]);
    XCTAssertTrue([typesOfProperties[@"date"] isEqualToString:@"NSDate"]);
    XCTAssertTrue([typesOfProperties[@"objInner"] isEqualToString:@"AGMyClass"]);
    XCTAssertTrue([typesOfProperties[@"array"] isEqualToString:@"NSArray"]);
}

- (void)testThatItCreatesStringPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMyClass class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string" keyTo:@"string"];
    XCTAssertEqual(pair.keyTo, @"string");
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual([pair class], [AGMappingPairString class]);
}

- (void)testThatItCreatesArrayPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMyClass class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"array"
                                                   params:@{
                                                            kAGMappingClassNameKey: @"NSNumber"
                                                            }];
    XCTAssertEqual([pair class], [AGMappingPairArray class]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"array");
    XCTAssertEqual(((AGMappingPairArray *)pair).entryClassName, @"NSNumber");
}

- (void)testThatItCreatesNumberPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMyClass class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"number"];
    XCTAssertEqual([pair class], [AGMappingPairNumber class]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"number");
}

- (void)testThatItCreatesDatePairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMyClass class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"date"
                                                   params:@{
                                                            kAGMappingDateFormatKey:@"yyyy"
                                                            }];
    XCTAssertEqual([pair class], [AGMappingPairDate class]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"date");
    XCTAssertEqual(((AGMappingPairDate *)pair).dateFormat, @"yyyy");
}

- (void)testThatItCreatesObjectPairWithGivenPrams {
    AGMappingPairBuilder *mpb = [[AGMappingPairBuilder alloc] init];
    mpb.mappingObjectClass = [AGMyClass class];
    AGMappingPair *pair = [mpb mappingPairWithKeyPathFrom:@"string"
                                                    keyTo:@"objInner"];
    XCTAssertEqual([pair class], [AGMappingPairObject class]);
    XCTAssertEqual(pair.keyPathFrom, @"string");
    XCTAssertEqual(pair.keyTo, @"objInner");
}
@end
