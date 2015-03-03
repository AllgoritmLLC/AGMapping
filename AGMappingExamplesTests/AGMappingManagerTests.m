//
//  AGMappingPairManagerTests.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMock.h"
#import "AGInvalidMapKeyToMock.h"
#import "AGInvalidMapKeyFromMock.h"
#import "AGMappingManager.h"
#import "AGMappingTestsHelper.h"

#import "AGMappingPairString.h"
#import "AGMappingPairArray.h"
#import "AGMappingPairNumber.h"
#import "AGMappingPairDate.h"
#import "AGMappingPairObject.h"

#import "AGMappingClassIsNotMappingComplaintException.h"
#import "AGMappingInvalidMappingFormatException.h"

@interface AGMappingManagerTests : XCTestCase

@end

@implementation AGMappingManagerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testThatItGivesSameSharedInstanceEveryTime {
    AGMappingManager *i1 = [AGMappingManager sharedInstance];
    AGMappingManager *i2 = [AGMappingManager sharedInstance];
    XCTAssertTrue(i1==i2);
}

- (void)testThatItInitsSelfProperties {
    AGMappingManager *m = [[AGMappingManager alloc] init];
    id mappingPairsByClassName = [m valueForKeyPath:@"mappingPairsByClassName"];
    XCTAssertTrue([mappingPairsByClassName isKindOfClass:[NSMutableDictionary class]]);
    XCTAssertEqual([[mappingPairsByClassName allKeys] count], 0);
}

-(void)testThatItCreatesMappingPairsForClassOnce {
    AGMappingManager *m = [AGMappingManager sharedInstance];
    NSArray *pairs = [m mappingPairsForClass:[AGMock class]];

    XCTAssertTrue([AGMappingTestsHelper array:pairs
                        containsObjectOfClass:[AGMappingPairObject class]]);
    XCTAssertTrue([AGMappingTestsHelper array:pairs
                        containsObjectOfClass:[AGMappingPairNumber class]]);
    XCTAssertTrue([AGMappingTestsHelper array:pairs
                        containsObjectOfClass:[AGMappingPairString class]]);
    XCTAssertTrue([AGMappingTestsHelper array:pairs
                        containsObjectOfClass:[AGMappingPairDate class]]);
    XCTAssertTrue([AGMappingTestsHelper array:pairs
                        containsObjectOfClass:[AGMappingPairArray class]]);
}

-(void)testThatItThrowsWhenKeyToIsNotStringOrDict{
    AGMappingManager *m = [AGMappingManager sharedInstance];
    XCTAssertThrowsSpecific([m mappingPairsForClass:[AGInvalidMapKeyToMock class]], AGMappingInvalidMappingFormatException);
}

-(void)testThatItThrowsWhenKeyFromIsNotString{
    AGMappingManager *m = [AGMappingManager sharedInstance];
    XCTAssertThrowsSpecific([m mappingPairsForClass:[AGInvalidMapKeyFromMock class]], AGMappingInvalidMappingFormatException);
}

@end
