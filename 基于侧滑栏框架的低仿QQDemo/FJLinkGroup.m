//
//  FJLinkGroup.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJLinkGroup.h"
#import "FJLinkFriends.h"

@implementation FJLinkGroup

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        //把self.friends由字典数组转换成模型数组
        NSMutableArray *arrayModels = [NSMutableArray array];
        for (NSDictionary *dict_sub in self.friends) {
            FJLinkFriends *model = [[FJLinkFriends alloc]initWithDict:dict_sub];
            [arrayModels addObject:model];
        }
        self.friends = arrayModels;
    }
    return self;
}

@end
