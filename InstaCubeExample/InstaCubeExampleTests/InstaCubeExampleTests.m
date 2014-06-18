//
//  InstaCubeExampleTests.m
//  InstaCubeExampleTests
//
//  Created by mrJacob on 6/15/14.
//  Copyright (c) 2014 sushiGrass. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Foundation/Foundation.h> 
#import <UIKit/UIKit.h>


@interface InstaCubeExampleTests : XCTestCase

@end

@implementation InstaCubeExampleTests

//- (void)setUp {
//    [super setUp];
//    // Put setup code here. This method is called before the invocation of each test method in the class.
//}
//
//- (void)tearDown {
//    // Put teardown code here. This method is called after the invocation of each test method in the class.
//    [super tearDown];
//}

- (void)testAllImagesFound {
    NSString *rootString = @"colorCube_";
    NSArray *cubeNameSuffixes = @[@"chrome",
                                  @"vibrance",
                                  @"threshold",
                                  @"solarize",
                                  @"warming",
                                  @"green",
                                  @"moody",
                                  @"posterize"];
    for (NSString *suffix in cubeNameSuffixes) {
        NSString *fileName = [rootString stringByAppendingString:suffix];
        UIImage *image = [UIImage imageNamed:fileName];
        XCTAssertNotNil(image, @"");
    }
}

@end
