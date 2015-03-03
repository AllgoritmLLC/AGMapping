//
//  AGMappingPairObjectTests.m
//  AGMappingExamples
//
//  Created by user on 02/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMappingTestcase.h"
#import "AGMyClass.h"
#import "AGMappingPairObject.h"
#import "AGMappingClassNameUndefinedException.h"

@interface AGMappingPairObjectTests : AGMappingTestcase

@end

@implementation AGMappingPairObjectTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testThatItMapsObject {
    AGMyClass *obj = [self createTestObj];
    AGMappingPairObject *mpObject = [AGMappingPairObject mappingPairWithKeyPathFrom:@"someField.objInner"
                                                                              keyTo:@"objInner"
                                                                          className:@"AGMyClass"];
    AGMyClass *objInner = [self createTestObj];
    objInner.string = @"1";
    objInner.number = @(1);
    NSDictionary *dict = @{
                              @"someField": @{
                                      @"objInner": @{
                                                @"string": @"1",
                                                @"number": @(1)
                                              }
                              }
                          };
    [mpObject mapValueFromJSONObject:dict toObject:obj];
    XCTAssertTrue([obj.objInner.string isEqualToString:objInner.string]);
    XCTAssertTrue([obj.objInner.number isEqualToNumber:objInner.number]);
}

- (void)testThatItMapsUndefinedToNil {
    AGMyClass *obj = [self createTestObj];
    NSDictionary *dict = @{
                           @"someField": @{}
                           };
    AGMappingPairObject *mpObject = [AGMappingPairObject mappingPairWithKeyPathFrom:@"someField.objInner"
                                                                              keyTo:@"objInner"
                                                                          className:@"AGMyClass"];
    [mpObject mapValueFromJSONObject:dict toObject:obj];
    XCTAssertNil(obj.objInner);
}

-(void)testThatItTwhrowsExceptionOnInitWithoutClassname {
    XCTAssertThrowsSpecific([AGMappingPairObject mappingPairWithKeyPathFrom:@"someField.objInner"
                                                                      keyTo:@"objInner"], AGMappingClassNameUndefinedException);
}

@end
