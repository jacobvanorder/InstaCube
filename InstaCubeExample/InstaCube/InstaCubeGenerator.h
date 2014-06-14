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
/**
 *  Generates a CIFilter of the type Color Cube based on the key image named within the bundle provided
 *
 *  @param keyImageString The name of the image supplied as the key image
 *  @param bundleOrNil    The bundle where to find the key image (optional)
 *
 *  @return A CIFilter of the type Color Cube. You will still need to set an import image.
 */
+ (CIFilter *)instaCubeWithKeyImageName:(NSString *)keyImageString onBundle:(NSBundle *)bundleOrNil;

/**
 *  Generates a CIFilter of the type Color Cube based on the key image provided as an UIImage
 *
 *  @param keyImage The key image as UIImage
 *
 *  @return A CIFilter of the type Color Cube. You will still need to set an import image.
 */
+ (CIFilter *)instaCubeWithKeyImage:(UIImage *)keyImage;

@end
