//
//  AGMappingPairArrayTests.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMappingPairArray.h"
#import "AGMappingClassNameUndefinedException.h"
#import "AGMyClass.h"

@interface AGMappingPairCollectionTests : XCTestCase

@end

@implementation AGMappingPairCollectionTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (NSDate *) testDate {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd-MM-yyyy"];
    return [df dateFromString:@"20-05-1989"];
}

-(void)testThatItTwhrowsExceptionOnInitWithoutClassname {
    XCTAssertThrowsSpecific([AGMappingPairArray mappingPairWithKeyPathFrom:@"someField.objInner"
                                                                          keyTo:@"objInner"], AGMappingClassNameUndefinedException);
}

-(void) testThatItCreatesMappingPairWithGivenParameters {
    AGMappingPairCollection *mpCollection = [AGMappingPairCollection mappingPairWithKeyPathFrom:@"from"
                                                                                         keyTo:@"to"
                                                                                entryClassName:@"name"
                                                                                entryClassInfo:@"info"];
    XCTAssertEqual(mpCollection.keyPathFrom, @"from");
    XCTAssertEqual(mpCollection.keyTo, @"to");
    XCTAssertEqual(mpCollection.entryClassName, @"name");
    XCTAssertEqual(mpCollection.entryClassInfo, @"info");
}

-(void) testThatItCreatesMappingPairWithoutEntryClassInfo {
    AGMappingPairCollection *mpCollection = [AGMappingPairCollection mappingPairWithKeyPathFrom:@"from"
                                                                                          keyTo:@"to"
                                                                                 entryClassName:@"name"];
    XCTAssertEqual(mpCollection.keyPathFrom, @"from");
    XCTAssertEqual(mpCollection.keyTo, @"to");
    XCTAssertEqual(mpCollection.entryClassName, @"name");
    XCTAssertNil(mpCollection.entryClassInfo);
}

-(void) testThatItRetrievesEntryClassWithGivenEntryClassName {
    AGMappingPairCollection *mpCollection = [AGMappingPairCollection mappingPairWithKeyPathFrom:@"from"
                                                                                          keyTo:@"to"
                                                                                 entryClassName:@"AGMyClass"];
    XCTAssertEqual(mpCollection.entryClass, [AGMyClass class]);
}

-(void) testThatItMapsEntryStringToString {
    NSString *s = [AGMappingPairCollection objectWithJSONValue:@"1" entryClass:[NSString class] entryClassInfo:nil];
    XCTAssertEqual(@"1", s);
};

-(void) testThatItMapsEntryDateToDate {
    NSDate *d = [AGMappingPairCollection objectWithJSONValue:@"20-05-1989"
                                                  entryClass:[NSDate class]
                                              entryClassInfo:@"dd-MM-yyyy"];
    XCTAssertEqual(d, [self testDate]);
    
}

-(void) testThatItMapsEntryObjectToObject {
    AGMyClass *obj = [AGMappingPairCollection objectWithJSONValue:@{
                                                                    @"number": @(1),
                                                                    @"string": @"1"
                                                                    }
                                                       entryClass:[AGMyClass class]
                                                   entryClassInfo:nil];

    XCTAssertEqual(obj.number, @(1));
    XCTAssertEqual(obj.string, @"1");
}




@end
