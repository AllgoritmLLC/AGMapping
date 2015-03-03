//
//  AGMappingPairTests.m
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AGMappingPairDate.h"
#import "AGMappingTestcase.h"

@interface AGMappingPairDateTests : AGMappingTestcase

@property (nonatomic, strong, readonly) NSDate *testDate;
@property (nonatomic, strong, readonly) NSDate *testObj;

@end

@implementation AGMappingPairDateTests

- (void)setUp {
    [super setUp];
}

- (NSDate *) testDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    return [df dateFromString:@"20-05-1989"];
}


- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItInitsWithGivenParameters {
    AGMappingPairDate *mpDate = [AGMappingPairDate mappingPairWithKeyPathFrom:@"keyFrom"
                                                                        keyTo:@"keyTo"
                                                                   dateFormat:@"dateFormat"];
    XCTAssertEqual([mpDate class], [AGMappingPairDate class]);
    XCTAssertEqual(mpDate.keyTo, @"keyTo");
    XCTAssertEqual(mpDate.keyPathFrom, @"keyFrom");
    XCTAssertEqual(mpDate.dateFormat, @"dateFormat");
}

- (void) testThatItCreatesDateFromGivenFormatString {
    NSDate *date = [AGMappingPairDate objectWithJSONValue:@"20-05-1989" dateFormat:@"dd-MM-yyyy"];
    XCTAssertEqual(date, self.testDate);
}

- (void) testThatItNotCreatesDateFromInvalidArgumentsType {
    NSDate *date = [AGMappingPairDate objectWithJSONValue:@(123) dateFormat:@"dd-mm-YYYY"];
    XCTAssertNil(date);
}

- (void) testThatItCreatesDateFromTimestampPresentedByNSNumber {
    NSDate *date = [AGMappingPairDate objectWithJSONValue:@(1425282646)];
    XCTAssertEqual(date, [NSDate dateWithTimeIntervalSince1970:1425282646]);
}

- (void) testThatItCreatesDateFromTimestampPresentedByString {
    NSDate *date = [AGMappingPairDate objectWithJSONValue:@"1425282646"];
    XCTAssertEqual(date, [NSDate dateWithTimeIntervalSince1970:1425282646]);
}

- (void) testThatItNotCreatesDateFromNil {
    NSDate *date = [AGMappingPairDate objectWithJSONValue:nil];
    XCTAssertNil(date);
}

- (void) testThatItMapsStringToDate {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                            @"date": @"20-05-1989"
                                          }
                          };
    AGMappingPairDate *mpDate = [AGMappingPairDate mappingPairWithKeyPathFrom:@"someField.date"
                                                                        keyTo:@"date"
                                                                   dateFormat:@"dd-MM-yyyy"];
    [mpDate mapValueFromJSONObject:dict toObject:obj];
    XCTAssertEqual(obj.date , self.testDate);
}

- (void) testThatItMapsTimetampToDate {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                   @"date": @(611611200)
                                   }
                           };

    AGMappingPairDate *mpDate = [AGMappingPairDate mappingPairWithKeyPathFrom:@"someField.date"
                                                                        keyTo:@"date"];

    [mpDate mapValueFromJSONObject:dict toObject:obj];
    XCTAssertEqual(obj.date, self.testDate);
}

@end
