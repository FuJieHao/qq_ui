//
//  UILabel+FJLabelCategory.m
//  生活圈
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "UILabel+FJLabelCategory.h"

@implementation UILabel (FJLabelCategory)

+ (instancetype)labelQuicklyFoundLabel:(NSString *)text andFont:(NSInteger)font andColor:(UIColor *)color
{
    
    UILabel *label = [[self alloc] init];
    label.text = text;
    label.font = [UIFont systemFontOfSize:font];
    label.textColor = color;
    
    return label;
}

@end
