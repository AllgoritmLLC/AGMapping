//
//  NSObject+AGMappingTests.m
//  AGMappingExamples
//
//  Created by user on 04/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMappingTestcase.h"
#import "AGMock.h"
#import "NSObject+AGMapping.h"

@interface NSObject_AGMappingTests : AGMappingTestcase

@end

@implementation NSObject_AGMappingTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItCreatesTypesOfOwnPropertiesDictionary {
    AGMock *obj = [self createTestObj];
    NSDictionary *props = [obj valueForKey:@"typesOfProperties"];
    
    XCTAssertTrue([props[@"number"] isEqualToString: @"NSNumber"]);
    XCTAssertTrue([props[@"string"] isEqualToString: @"NSString"]);
    XCTAssertTrue([props[@"date"] isEqualToString: @"NSDate"]);
    XCTAssertTrue([props[@"array"] isEqualToString: @"NSArray"]);
    XCTAssertTrue([props[@"objInner"] isEqualToString: @"AGMock"]);
}

- (void) testThatItCreatesObjectFromDictionary {
    NSArray * arr = @[@(1), @(2), @(3)];
    NSDictionary *dict = @{
                           @"number": @(123),
                           @"string": @"string",
                           @"array": arr,
                           @"objInner": @{
                                        @"number": @(321),
                                        @"string": @"string",
                                        @"array": arr,
                                   }
                           };
    AGMock *obj = [AGMock objectMappedFromJSONObject:dict];
    XCTAssertTrue([obj.number isEqualToNumber:@(123)]);
    XCTAssertTrue([obj.string isEqualToString:@"string"]);
    XCTAssertTrue([obj.array isEqualToArray:arr]);
    XCTAssertTrue([obj.objInner.number isEqualToNumber:@(321)]);
    XCTAssertTrue([obj.objInner.string isEqualToString:@"string"]);
    XCTAssertTrue([obj.objInner.array isEqualToArray:arr]);
}

- (void) testThatItMapsDictionaryToSelf {
    AGMock *obj = [self createTestObj];
    NSArray * arr = @[@(1), @(2), @(3)];
    NSDictionary *dict = @{
                           @"number": @(123),
                           @"string": @"string",
                           @"array": arr,
                           @"objInner": @{
                                   @"number": @(321),
                                   @"string": @"string",
                                   @"array": arr,
                                   }
                           };
    [obj mapValuesFromJSONObject:dict];
    XCTAssertTrue([obj.number isEqualToNumber:@(123)]);
    XCTAssertTrue([obj.string isEqualToString:@"string"]);
    XCTAssertTrue([obj.array isEqualToArray:arr]);
    XCTAssertTrue([obj.objInner.number isEqualToNumber:@(321)]);
    XCTAssertTrue([obj.objInner.string isEqualToString:@"string"]);
    XCTAssertTrue([obj.objInner.array isEqualToArray:arr]);

    
}

-(void) testThatItCreatesArrayOfObjectsFromArrayOfDictionaries {
    NSArray * arr = @[@(1), @(2), @(3)];
    NSArray *testArr = @[@{
                                                  @"number": @(1),
                                                  @"string": @"string1",
                                                  @"array": arr,
                                                  @"objInner": @{
                                                          @"number": @(11),
                                                          @"string": @"string11",
                                                          @"array": arr,
                                                          }
                                                  },
                                                @{
                                                  @"number": @(2),
                                                  @"string": @"string2",
                                                  @"array": arr,
                                                  @"objInner": @{
                                                          @"number": @(22),
                                                          @"string": @"string22",
                                                          @"array": arr,
                                                          }
                                                  }];
    
    NSArray *resultArr = [AGMock objectsMappedFromJSONArray:testArr];
    
    XCTAssertEqual([resultArr count], 2);
    
    XCTAssertTrue([((AGMock *)resultArr[0]).number isEqualToNumber:@(1)]);
    XCTAssertTrue([((AGMock *)resultArr[0]).string isEqualToString:@"string1"]);
    XCTAssertTrue([((AGMock *)resultArr[0]).array isEqualToArray:arr]);
    XCTAssertTrue([((AGMock *)resultArr[0]).objInner.number isEqualToNumber:@(11)]);
    XCTAssertTrue([((AGMock *)resultArr[0]).objInner.string isEqualToString:@"string11"]);
    XCTAssertTrue([((AGMock *)resultArr[0]).objInner.array isEqualToArray:arr]);
    
    XCTAssertTrue([((AGMock *)resultArr[1]).number isEqualToNumber:@(2)]);
    XCTAssertTrue([((AGMock *)resultArr[1]).string isEqualToString:@"string2"]);
    XCTAssertTrue([((AGMock *)resultArr[1]).array isEqualToArray:arr]);
    XCTAssertTrue([((AGMock *)resultArr[1]).objInner.number isEqualToNumber:@(22)]);
    XCTAssertTrue([((AGMock *)resultArr[1]).objInner.string isEqualToString:@"string22"]);
    XCTAssertTrue([((AGMock *)resultArr[0]).objInner.array isEqualToArray:arr]);
}

@end
