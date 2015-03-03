//
//  AGMappingPairCollectionTest.m
//  AGMappingExamples
//
//  Created by user on 03/03/15.
//  Copyright (c) 2015 Allgoritm LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AGMappingPairCollection.h"
#import "AGMappingClassNameUndefinedException.h"

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

-(void)testThatItTwhrowsExceptionOnInitWithoutClassname {
    XCTAssertThrowsSpecific([AGMappingPairCollection mappingPairWithKeyPathFrom:@"someField.objInner"
                                                                      keyTo:@"objInner"], AGMappingClassNameUndefinedException);
}


@end
