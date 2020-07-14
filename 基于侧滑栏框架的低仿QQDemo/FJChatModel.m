//
//  FJChatModel.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJChatModel.h"

@implementation FJChatModel

/**
 *  数据存储
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.text forKey:@"text"];
    [aCoder encodeObject:self.time forKey:@"time"];
    [aCoder encodeObject:self.identifier forKey:@"identifier"];
}

/**
 *  数据解析
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.text = [aDecoder decodeObjectForKey:@"text"];
        self.time = [aDecoder decodeObjectForKey:@"time"];
        self.identifier = [aDecoder decodeObjectForKey:@"identifier"];
    }
    return self;
}

@end
