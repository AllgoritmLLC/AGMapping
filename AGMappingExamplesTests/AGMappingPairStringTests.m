//
//  AGMappingPairStringTests.m
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMock.h"
#import "AGMappingPairString.h"
#import "AGMappingTestcase.h"

@interface AGMappingPairStringTests : AGMappingTestcase

@end

@implementation AGMappingPairStringTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) testThatItMapsString {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{
                                   @"string": @"123"
                                   }
                           };
    
    AGMappingPairString *mpString = [AGMappingPairString mappingPairWithKeyPathFrom:@"someField.string"
                                                                        keyTo:@"string"];
    
    [mpString mapValueFromJSONObject:dict toObject:obj];
    XCTAssertEqual(obj.string, @"123");
}

- (void) testThatItMapsUndefinedToNil {
    AGMock *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{}
                           };
    AGMappingPairString *mpString = [AGMappingPairString mappingPairWithKeyPathFrom:@"someField.string"
                                                                              keyTo:@"string"];
    [mpString mapValueFromJSONObject:dict toObject:obj];
    XCTAssertNil(obj.string);
}

- (void) testThatItMapsNullToNil {
    id smth =[AGMappingPairString objectWithJSONValue:[NSNull null]];
    XCTAssertNil(smth);
}

-(void) testThatItMapsObjectToString {
    AGMock *obj = [self createTestObj];
    AGMock *objInner = [self createTestObj];
    objInner.string = @"1";
    objInner.number = @(1);
    NSDictionary *dict = @{
                           @"someField": @{
                                        @"string": objInner
                                   }
                           };
    AGMappingPairString *mpString = [AGMappingPairString mappingPairWithKeyPathFrom:@"someField.string"
                                                                              keyTo:@"string"];
    [mpString mapValueFromJSONObject:dict toObject:obj];
    XCTAssertTrue([obj.string isEqualToString:objInner.description]);
}


@end
