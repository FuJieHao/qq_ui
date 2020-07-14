//
//  ViewController.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJBaseViewController : UIViewController

//设置滑动系数
@property (nonatomic,assign) CGFloat speed;

//采用多态松耦的方式来定义两个控制器
@property (nonatomic,strong) UIViewController *leftVC;
@property (nonatomic,strong) UITabBarController *mainVC;

//这里还缺一个点击手势控制器，和滑动手势控制器
//(滑动）
@property (nonatomic,strong) UIPanGestureRecognizer *pan;

//sideslipTapGes(点击),默认为YES（1）
@property (nonatomic,strong) UITapGestureRecognizer *sideslipTapGes;

//设置关闭侧滑栏
@property (nonatomic,assign) BOOL isClosed;

//定义一个添加其两个子类控制器的方法
- (instancetype)initWithLeftViewController:(UIViewController *)leftVC andMainController:(UITabBarController *)mainVC;

//关闭和打开侧栏的方法
- (void)closeLeftViewController;

- (void)openLeftViewController;

//时候开启滑动手势的功能 手势pan
- (void)setPanEnabled:(BOOL)enabled;

@end

