//
//  FJTabBarController.m
//  侧滑栏封装
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJTabBarController.h"
#import "FJNavigationViewController.h"

@interface FJTabBarController ()

@end

@implementation FJTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.translucent = NO;
    
    UIViewController *first = [self loadChildViewControllerWithClassName:@"FJMessageTableViewController" andTitle:@"消息" andImageName:@"tab_recent_nor_none"];
    
    UIViewController *second = [self loadChildViewControllerWithClassName:@"FJLinkManTableViewController" andTitle:@"联系人" andImageName:@"tab_buddy_nor_none"];
    
    UIViewController *third = [self loadChildViewControllerWithClassName:@"FJDynamicTableViewController" andTitle:@"动态" andImageName:@"tab_qworld_nor_none"];
    
    self.viewControllers = @[first,second,third];
}

- (UIViewController *)loadChildViewControllerWithClassName:(NSString *)className andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    Class class = NSClassFromString(className);
    
    UIViewController *vc = [[class alloc] init];
    
    return [self setupTabBarItemAndNavigationControllerWithRootViewController:vc andTitle:title andImageName:imageName];
}

- (UIViewController *)loadChildViewControllerWithStoryboardName:(NSString *)sbName andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:sbName bundle:nil];
    UIViewController *vc = [sb instantiateInitialViewController];
    
    return [self setupTabBarItemAndNavigationControllerWithRootViewController:vc andTitle:title andImageName:imageName];
}


- (UIViewController *)setupTabBarItemAndNavigationControllerWithRootViewController:(UIViewController *)viewController andTitle:(NSString *)title andImageName:(NSString *)imageName {
    
    viewController.title = title;
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@_1", imageName]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    FJNavigationViewController *nav = [[FJNavigationViewController alloc] initWithRootViewController:viewController];
    return nav;
}

@end
