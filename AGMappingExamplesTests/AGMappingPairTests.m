//
//  AGMappingPairTests.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMock.h"
#import "AGMappingPair.h"
#import "AGMappingTestcase.h"
#import "VBNotImplementedException.h"

@interface AGMappingPairTests : AGMappingTestcase

@end

@implementation AGMappingPairTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCreatesMappingPairWithGivenParams {
    AGMappingPair *pair = [AGMappingPair mappingPairWithKeyPathFrom:@"from"
                                                              keyTo:@"to"];
    XCTAssertEqual(pair.keyPathFrom, @"from");
    XCTAssertEqual(pair.keyTo, @"to");
}

- (void)testThatItMaps {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                   @"array": @[@(1), @(2)]
                                   }
                           };
    AGMappingPair *mp = [AGMappingPair mappingPairWithKeyPathFrom:@"someField.array"
                                                            keyTo:@"array"];
    [mp mapValueFromJSONObject:dict toObject:obj];
    NSArray *arr = @[@(1), @(2)];
    XCTAssertTrue([obj.array isEqualToArray:arr]);
}

- (void) testThaiItThrowsOnGettingObjectFromJson {
    XCTAssertThrowsSpecific([AGMappingPair objectWithJSONValue:@"blah"], VBNotImplementedException);
}

@end
