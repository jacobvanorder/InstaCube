//
//  InstaCubeGenerator.h
//  InstaCube
//
//  Created by mrJacob on 6/14/14.
//  Copyright (c) 2014 sushiGrass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CIFilter;

@interface InstaCubeGenerator : NSObject

+ (CIFilter *)instaCubeWithKeyImageName:(NSString *)keyImageString onBundle:(NSBundle *)bundleOrNil;

+ (CIFilter *)instaCubeWithKeyImage:(UIImage *)keyImage;

@end
