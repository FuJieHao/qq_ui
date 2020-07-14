//
//  FJSliderManager.m
//  侧滑栏封装
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSliderManager.h"

static id _instance;

@implementation FJSliderManager

+ (instancetype)sharedSliderInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

@end
