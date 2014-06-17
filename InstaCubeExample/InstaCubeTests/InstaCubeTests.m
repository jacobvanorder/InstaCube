//
//  InstaCubeTests.m
//  InstaCubeTests
//
//  Created by mrJacob on 6/15/14.
//  Copyright (c) 2014 sushiGrass. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "InstaCube.h"

@interface InstaCubeTests : XCTestCase

@property (nonatomic, strong) NSBundle *testBundle;
@property (nonatomic, strong, readonly) NSString *colorCubeString;

@end

@implementation InstaCubeTests

- (void)setUp {
    [super setUp];
    self.testBundle = [NSBundle bundleForClass:[self class]];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testInstaCubeWithImageName {
    [self measureBlock:^{
        CIFilter *filter = [InstaCubeGenerator instaCubeWithKeyImageName:self.colorCubeString onBundle:self.testBundle];
        XCTAssertNotNil(filter, @"");
    }];
}

- (void)testInstaCubeWithImage {
    NSString *path = [self.testBundle pathForResource:self.colorCubeString ofType:@"png"];
    XCTAssertNotNil(path, @"");
    NSData *imageData = [NSData dataWithContentsOfFile:path];
    XCTAssertNotNil(imageData, @"");
    UIImage *colorCubeMoody = [UIImage imageWithData:imageData];
    XCTAssertNotNil(colorCubeMoody, @"");
    [self measureBlock:^{
        CIFilter *filter = [InstaCubeGenerator instaCubeWithKeyImage:colorCubeMoody];
        XCTAssertNotNil(filter, @"");
    }];
}

- (NSString *)colorCubeString {
    return @"colorCube_moody";
}

//- (void)testPerformanceExample {
//    // This is an example of a performance test case.
//    [self measureBlock:^{
//        // Put the code you want to measure the time of here.
//    }];
//}

@end
