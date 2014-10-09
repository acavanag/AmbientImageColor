//
//  ImageTest.m
//  Reviews
//
//  Created by Andrew Cavanagh on 10/9/14.
//  Copyright (c) 2014 WeddingWire. All rights reserved.
//

#import "ImageTest.h"

typedef struct pixel {
    unsigned char r, g, b, a;
} Pixel;

@implementation ImageTest

+ (UIColor *)averageColorForImage:(UIImage *)image {
    CGImageRef imageRef = [image CGImage];

    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    Pixel *pixels = (struct pixel*) calloc(1, image.size.width * image.size.height * sizeof(struct pixel));
    
    unsigned short bitsPerComponent = 8;
    unsigned short bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    
    CGContextRef contextRef = CGBitmapContextCreate((void*)pixels, width, height, bitsPerComponent, bytesPerRow, colorSpaceRef, kCGImageAlphaPremultipliedLast|kCGBitmapByteOrder32Big);
    
    CGContextDrawImage(contextRef, CGRectMake(0, 0, width, height), imageRef);
    
    NSUInteger numberOfPixles = width * height;
    unsigned char reds[numberOfPixles];
    unsigned char greens[numberOfPixles];
    unsigned char blues[numberOfPixles];
    
    int index = 0;
    while (numberOfPixles > 0) {
        reds[index] = pixels->r;
        greens[index] = pixels->g;
        blues[index] = pixels->b;

        index++;
        pixels++;
        numberOfPixles--;
    }
    
    numberOfPixles = width * height;
    double redSum = 0;
    double greenSum = 0;
    double blueSum = 0;
    for (int i = 0; i < numberOfPixles; i++) {
        redSum = redSum + reds[i];
        greenSum = greenSum + greens[i];
        blueSum = blueSum + blues[i];
    }
    
    double redAverage = (redSum/numberOfPixles)/255;
    double greenAverage = (greenSum/numberOfPixles)/255;
    double blueAverage = (greenSum/numberOfPixles)/255;

    UIColor *averageColor = [UIColor colorWithRed:redAverage green:greenAverage blue:blueAverage alpha:1.0f];
    
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(contextRef);
    //free(pixels);
    
    return averageColor;
}

@end
