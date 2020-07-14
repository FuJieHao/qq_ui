//
//  FJMessageModel.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJMessageModel : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *subTitle;
@property (nonatomic,assign) NSInteger notRead;

@property (nonatomic,strong) NSMutableArray *chatModelArray;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
