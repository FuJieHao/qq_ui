//
//  FJNavigationViewController.m
//  侧滑栏封装
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJNavigationViewController.h"

@interface FJNavigationViewController ()

@end

@implementation FJNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //清空导航栏的背景图片
    [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    
    //去掉阴影图片(导航条下面的）
    self.navigationBar.shadowImage = [[UIImage alloc]init];
    
    //去掉半透明效果
    self.navigationBar.translucent = NO;
    
    //上面这三个设置完，就已经没有了那条线线
//    25 168  243

    self.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:168/255.0 blue:243/255.0 alpha:1];
    
    // 可以创建一个label设置给它的titleView属性
    //    self.navigationItem.titleView
    
    // 设置导航条中间标题文字属性来更改文字颜色及文字字体(属性)
    // NSFontAttributeName此KEY表示的是字体
    // NSForegroundColorAttributeName 此KEY文字颜色
    self.navigationBar.titleTextAttributes = @{NSFontAttributeName : [UIFont systemFontOfSize:14], NSForegroundColorAttributeName : [UIColor whiteColor]};
}

@end
