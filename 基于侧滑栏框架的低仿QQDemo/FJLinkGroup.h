//
//  FJLinkGroup.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FJLinkGroup : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger online;
@property (nonatomic,strong) NSArray *friends;
@property (nonatomic,assign,getter=isVisible) BOOL visible;

@end
