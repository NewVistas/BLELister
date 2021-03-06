//
//  BSJSONParserTests.m
//  BLELister
//
//  Created by Steve Baker on 9/29/13.
//  Copyright (c) 2013 Beepscore LLC. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BSJSONParser.h"

@interface BSJSONParserTests : XCTestCase

@end

@implementation BSJSONParserTests

- (void)setUp {
    [super setUp];
    // Put setup code here; it will be run once, before the first test case.
}

- (void)tearDown {
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testArrayFromJSON {

    NSArray *expectedArray = @[@"Larry", @"Moe", @57, @"Curly"];

    NSString *testString = @"[\"Larry\", \"Moe\", 57, \"Curly\"]";
    NSArray *actualArray = [BSJSONParser arrayFromJSON:testString];
    
    XCTAssertEqualObjects(expectedArray, actualArray, @"");
}

- (void)testArrayFromJSONEmpty {

    NSArray *expectedArray = @[];

    NSString *testString = @"";
    NSArray *actualArray = [BSJSONParser arrayFromJSON:testString];
    
    XCTAssertEqualObjects(expectedArray, actualArray, @"");
}

- (void)testArrayFromJSONNil {
    NSArray *expectedArray = @[];
    NSArray *actualArray = [BSJSONParser arrayFromJSON:nil];
    XCTAssertEqualObjects(expectedArray, actualArray, @"");
}

- (void)testArrayFromJSONFile {
    NSArray *expectedArray = @[@"Larry", @"Moe", @57, @"Curly"];

    NSArray *actualArray = [BSJSONParser arrayFromJSONFile:@"stubArray"];

    XCTAssertEqualObjects(expectedArray, actualArray, @"");
}

- (void)testDictFromJSON {

    NSDictionary *expectedDict = @{@"redbearshield":@{@"identifier":@"DDAB0207-5E10-2902-5B03-CA3F0F466B40", @"name":@"BLE Shield"},@"sensortag":@{@"identifier":@"B42E4E5D-B2D3-F03F-3139-7B735C8E8964",@"name":@"TI BLE Sensor Tag"}};

    NSString *testString = @"{\"redbearshield\":{\"identifier\":\"DDAB0207-5E10-2902-5B03-CA3F0F466B40\",\"name\":\"BLE Shield\"},\"sensortag\":{\"identifier\":\"B42E4E5D-B2D3-F03F-3139-7B735C8E8964\",\"name\":\"TI BLE Sensor Tag\"}}";
    NSDictionary *actualDict = [BSJSONParser dictFromJSON:testString];
    
    XCTAssertEqualObjects(expectedDict, actualDict, @"");
}

- (void)testDictFromJSONWithNull {

    NSDictionary *expectedDict = @{@"raspberry_pi":@{@"identifier":@"D2BD8809-5D04-9C44-650D-86E3A5CC3D82", @"name":[NSNull null]}};

    NSString *testString = @"{\"raspberry_pi\":{\"identifier\":\"D2BD8809-5D04-9C44-650D-86E3A5CC3D82\",\"name\":null}}";

    NSDictionary *actualDict = [BSJSONParser dictFromJSON:testString];
    
    XCTAssertEqualObjects(expectedDict, actualDict, @"");
}

- (void)testDictFromJSONEmpty {

    NSDictionary *expectedDict = @{};

    NSString *testString = @"";
    NSDictionary *actualDict = [BSJSONParser dictFromJSON:testString];
    
    XCTAssertEqualObjects(expectedDict, actualDict, @"");
}

- (void)testDictFromJSONNil {
    NSDictionary *expectedDict = @{};
    NSDictionary *actualDict = [BSJSONParser dictFromJSON:nil];
    XCTAssertEqualObjects(expectedDict, actualDict, @"");
}

- (void)testDictFromJSONFile {
    NSDictionary *expectedDict = @{
                                   @"flex":@{@"identifier":@"74451A09-E51B-5596-546C-C91A721EBC3D", @"name":@"Flex"},
                                   @"one":@{@"identifier":@"5FEA635E-4E9D-D84C-5713-4D004AABEFA3", @"name":@"One"},
                                   @"raspberry_pi":@{@"identifier":@"D2BD8809-5D04-9C44-650D-86E3A5CC3D82", @"name":[NSNull null]},
                                   @"redbearshield":@{@"identifier":@"DDAB0207-5E10-2902-5B03-CA3F0F466B40", @"name":@"BLE Shield"},
                                   @"sensortag":@{@"identifier":@"E8810024-0942-7800-E216-67FFE4E226AC",@"name":@"TI BLE Sensor Tag"}
                                   };
    
    NSDictionary *actualDict = [BSJSONParser dictFromJSONFile:@"bleDevices"];

    XCTAssertEqualObjects(expectedDict, actualDict, @"");
}

- (void)testJSONStringFromFile {
    NSString *expectedString = @"{\"flex\":{\"identifier\":\"74451A09-E51B-5596-546C-C91A721EBC3D\",\"name\":\"Flex\"},\"one\":{\"identifier\":\"5FEA635E-4E9D-D84C-5713-4D004AABEFA3\",\"name\":\"One\"},\"raspberry_pi\":{\"identifier\":\"D2BD8809-5D04-9C44-650D-86E3A5CC3D82\",\"name\":null},\"redbearshield\":{\"identifier\":\"DDAB0207-5E10-2902-5B03-CA3F0F466B40\",\"name\":\"BLE Shield\"},\"sensortag\":{\"identifier\":\"E8810024-0942-7800-E216-67FFE4E226AC\",\"name\":\"TI BLE Sensor Tag\"}}";

    NSString *actualString = [BSJSONParser JSONStringFromFile:@"bleDevices"];
    NSLog(@"expectedString %@, length, %ld",
                 expectedString, [expectedString length]);
    NSLog(@"actualString %@, length %ld",
                 actualString,[actualString length]);
    
    // Testing length checks two strings that appear similar except for newline at end.
    XCTAssertEqual([expectedString length], [actualString length], @"");
    XCTAssertEqualObjects(expectedString, actualString, @"");
}

@end
