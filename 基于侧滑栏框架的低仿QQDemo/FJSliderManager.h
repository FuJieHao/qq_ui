//
//  FJSliderManager.h
//  侧滑栏封装
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FJBaseViewController.h"

@interface FJSliderManager : NSObject

+ (instancetype)sharedSliderInstance;

@property (nonatomic, strong) FJBaseViewController *leftSliderVC;
@property (nonatomic, strong) UINavigationController *mainNavigationController;

@end
