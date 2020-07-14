//
//  FJLinkFriends.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJLinkFriends : NSObject

@property (nonatomic,copy) NSString *qq;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *intro;
@property (nonatomic,assign) BOOL vip;
@property (nonatomic,copy) NSString *status;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
