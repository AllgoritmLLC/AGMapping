//
//  AGMappingExamplesTests.m
//  AGMappingExamplesTests
//
//  Created by develop on 04/02/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "AGMovie.h"

@interface AGMappingExamplesTests : XCTestCase

@end

@implementation AGMappingExamplesTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    NSDictionary* json = @{@"id":       @(123),
                           @"poster": @{@"poster_small":    @"url for poster_small",
                                        @"poster_big":      @"url for poster_big"},
                           @"genre": @{@"name": @"comedy"},
                           @"cast": @[@{@"id":      @(100500),
                                        @"name":    @"John"},
                                      @{@"id":      @(100501),
                                        @"name":    @"Victoria"}],
                           @"date": @"2010/01/01",
                           @"countries": @[@"Russia", @"USA"]};
    
    AGMovie* movie = [AGMovie objectMappedFromJSONObject:json];
    
    NSLog(@"%@", movie);
    
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
