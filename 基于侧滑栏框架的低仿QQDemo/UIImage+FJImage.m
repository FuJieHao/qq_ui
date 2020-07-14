//
//  UIImage+FJImage.m
//  FJButton
//
//  Created by Mac on 16/8/17.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "UIImage+FJImage.h"

@implementation UIImage (FJImage)

- (UIImage *)scaleToscale:(CGFloat)scale
{
    CGSize size = CGSizeMake(self.size.width * scale, self.size.height * scale);
    
    UIImage *image = [self smallImage:size];
    
    return image;
}

- (UIImage *)scaleTosize:(CGSize)size
{
    UIImage *image = [self smallImage:size];
    
    return image;
}

- (UIImage *)smallImage:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}

@end
