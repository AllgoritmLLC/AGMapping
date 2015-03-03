//
//  AGMappingPairArrayTests.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMock.h"
#import "AGMappingTestcase.h"
#import "AGMappingPairArray.h"

@interface AGMappingPairArrayTests : AGMappingTestcase

@end

@implementation AGMappingPairArrayTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is call`ed after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItMapsArrayToArray {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                   @"array": @[@(1), @(2)]
                                   }
                           };
    AGMappingPairArray *mpArray = [AGMappingPairArray mappingPairWithKeyPathFrom:@"someField.array"
                                                                           keyTo:@"array"
                                                                  entryClassName:@"NSNumber"];
    [mpArray mapValueFromJSONObject:dict toObject:obj];
    NSArray *arr = @[@(1), @(2)];
    XCTAssertTrue([obj.array isEqualToArray:arr]);
    
}

- (void)testThatItMapsUndefinedToNil {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{}
                           };
    AGMappingPairArray *mpArray = [AGMappingPairArray mappingPairWithKeyPathFrom:@"someField.array"
                                                                           keyTo:@"array"
                                                                  entryClassName:@"NSNumber"];
    [mpArray mapValueFromJSONObject:dict toObject:obj];
    XCTAssertNil(obj.array);
}

@end
