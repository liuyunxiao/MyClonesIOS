//
//  UIImage+ScaleAddition.m
//  TextParser
//
//  Created by bw ye on 11-12-27.
//  Copyright (c) 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIImage+ScaleAddition.h"

@implementation UIImage(ScaleAddition)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;      
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }      
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)imageScaledWithConstrainedSize:(CGSize)aTargetSize
{
    CGFloat width = self.size.width;
    CGFloat height = self.size.height;
    
    if (CGSizeEqualToSize(CGSizeZero, self.size) || CGSizeEqualToSize(CGSizeZero, aTargetSize))
    {
        return nil;
    }
    
    CGFloat factor = width/height;
    
    CGFloat targetHeight = aTargetSize.height;
    CGFloat targetWidth = aTargetSize.width;
    
    if (factor > aTargetSize.width/aTargetSize.height)
    {
        targetHeight = height * targetWidth / width;
    }
    else
    {
        targetWidth = width * targetHeight / height;
    }
    
    return [self imageByScalingAndCroppingForSize:CGSizeMake(targetWidth, targetHeight)];
}

@end
