//
//  InstaCubeGenerator.m
//  InstaCube
//
//  Created by mrJacob on 6/14/14.
//  Copyright (c) 2014 sushiGrass. All rights reserved.
//

#import "InstaCubeGenerator.h"
#import <CoreGraphics/CoreGraphics.h>
#import <CoreImage/CoreImage.h>

@implementation InstaCubeGenerator

#pragma mark - public methods

+ (CIFilter *)instaCubeWithKeyImageName:(NSString *)keyImageString onBundle:(NSBundle *)bundleOrNil {
    NSBundle *bundle = (bundleOrNil) ? : [NSBundle mainBundle];
    UIImage *keyImage = [UIImage imageNamed:keyImageString
                                   inBundle:bundle
              compatibleWithTraitCollection:nil];
    if (keyImage) {
        return [self instaCubeWithKeyImage:keyImage];
    }
    
    return nil;
}

+ (CIFilter *)instaCubeWithKeyImage:(UIImage *)keyImage {
    
    CGImageRef keyCgImage = keyImage.CGImage;
    int sizeOfCube = floor(CGImageGetWidth(keyCgImage));
    NSData *colorCubeNSData = [self colorCubeDataForCGImageRef:keyCgImage];
    
    CIFilter *instaCube = [CIFilter filterWithName:@"CIColorCube"
                               withInputParameters:@{@"inputCubeDimension" : @(sizeOfCube),
                                                     @"inputCubeData" : colorCubeNSData}];
    
    return instaCube;
}

#pragma mark - private methods

+(NSData *) colorCubeDataForCGImageRef:(CGImageRef)imageRef {
    
    NSData *cubeNSData;
    const unsigned int size = floor(CGImageGetWidth(imageRef));
    
    NSUInteger cubeDataSize = ( size * size * size * sizeof(char) * 4);
    char *cubeCharData = [self convertCGImageRefToBitmapRGBA8CharData:imageRef];
    
    cubeNSData = [NSData dataWithBytesNoCopy:cubeCharData length:cubeDataSize freeWhenDone:YES];
    
    return cubeNSData;
}

+ (char *) convertCGImageRefToBitmapRGBA8CharData:(CGImageRef)imageRef {
    
    // Create a bitmap context to draw the uiimage into
    CGContextRef context = [self newBitmapRGBA8ContextFromImage:imageRef];
    
    if(!context) {
        return NULL;
    }
    
    size_t width = CGImageGetWidth(imageRef);
    size_t height = CGImageGetHeight(imageRef);
    
    CGRect rect = CGRectMake(0, 0, width, height);
    
    // Draw image into the context to get the raw image data
    CGContextDrawImage(context, rect, imageRef);
    
    // Get a pointer to the data
    char *bitmapData = ( char *)CGBitmapContextGetData(context);
    
    // Copy the data and release the memory (return memory allocated with new)
    size_t bytesPerRow = CGBitmapContextGetBytesPerRow(context);
    size_t bufferLength = bytesPerRow * height;
    
    char *newBitmap = NULL;
    
    if(bitmapData) {
        newBitmap = ( char *)malloc(sizeof( char) * bytesPerRow * height);
        
        if(newBitmap) {	// Copy the data
            for(size_t i = 0; i < bufferLength; ++i) {
                newBitmap[i] = bitmapData[i];
            }
        }
        
        free(bitmapData);
        
    } else {
        NSLog(@"Error getting bitmap pixel data\n");
        free(bitmapData);
    }
    
    CGContextRelease(context);
    
    return newBitmap;
}

+ (CGContextRef) newBitmapRGBA8ContextFromImage:(CGImageRef) image {
    CGContextRef context = NULL;
    CGColorSpaceRef colorSpace;
    uint32_t *bitmapData;
    
    size_t bitsPerPixel = 32;
    size_t bitsPerComponent = 8;
    size_t bytesPerPixel = bitsPerPixel / bitsPerComponent;
    
    size_t width = CGImageGetWidth(image);
    size_t height = CGImageGetHeight(image);
    
    size_t bytesPerRow = width * bytesPerPixel;
    size_t bufferLength = bytesPerRow * height;
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    
    if(!colorSpace) {
        NSLog(@"Error allocating color space RGB\n");
        return NULL;
    }
    
    // Allocate memory for image data
    bitmapData = (uint32_t *)malloc(bufferLength);
    
    if(!bitmapData) {
        NSLog(@"Error allocating memory for bitmap\n");
        CGColorSpaceRelease(colorSpace);
        return NULL;
    }
    
    //Create bitmap context
    context = CGBitmapContextCreate(bitmapData,
                                    width,
                                    height,
                                    bitsPerComponent,
                                    bytesPerRow,
                                    colorSpace,
                                    (CGBitmapInfo)kCGImageAlphaPremultipliedLast);	// RGBA
    if(!context) {
        free(bitmapData);
        NSLog(@"Bitmap context not created");
    }
    
    CGColorSpaceRelease(colorSpace);
    
    return context;
}

@end
