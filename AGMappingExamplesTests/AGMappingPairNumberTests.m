//
//  AGMappingPairNumberTests.m
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMyClass.h"
#import "AGMappingPairNumber.h"
#import "AGMappingTestcase.h"
@interface AGMappingPairNumberTests : AGMappingTestcase

@end

@implementation AGMappingPairNumberTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItMapsNumber {
    AGMyClass *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                   @"number": @(123)
                                   }
                           };
    AGMappingPairNumber *mpNumber = [AGMappingPairNumber mappingPairWithKeyPathFrom:@"someField.number"
                                                                              keyTo:@"number"];
    [mpNumber mapValueFromJSONObject:dict toObject:obj];
    XCTAssertEqual(obj.number, @(123));
}

- (void)testThatItMapsUndefinedToNil {
    AGMyClass *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{}
                          };
    AGMappingPairNumber *mpNumber = [AGMappingPairNumber mappingPairWithKeyPathFrom:@"someField.number"
                                                                              keyTo:@"number"];
    [mpNumber mapValueFromJSONObject:dict toObject:obj];
    XCTAssertNil(obj.number);
}

- (void) testThatItMapsNullToNil {
    id smth =[AGMappingPairNumber objectWithJSONValue:[NSNull null]];
    XCTAssertNil(smth);
}


- (void)testThatItMapsStringToNumber {
    AGMyClass *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                            @"number": @"123"
                                        }
                           };
    AGMappingPairNumber *mpNumber = [AGMappingPairNumber mappingPairWithKeyPathFrom:@"someField.number"
                                                                              keyTo:@"number"];
    [mpNumber mapValueFromJSONObject:dict toObject:obj];
    XCTAssertEqual(obj.number, [NSNumber numberWithLong:123]);
}

- (void)testThatItMapsFloatingPointStringToNumber {
    AGMyClass *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                   @"number": @"123.43"
                                   }
                           };
    AGMappingPairNumber *mpNumber = [AGMappingPairNumber mappingPairWithKeyPathFrom:@"someField.number"
                                                                              keyTo:@"number"];
    [mpNumber mapValueFromJSONObject:dict toObject:obj];
    XCTAssertTrue([obj.number isEqualToNumber:@(123.43)]);
}

@end
