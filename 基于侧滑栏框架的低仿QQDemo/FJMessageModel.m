//
//  FJMessageModel.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJMessageModel.h"

@implementation FJMessageModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
