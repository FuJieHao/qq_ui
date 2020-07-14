//
//  FJLinkManTableViewController.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJLinkManTableViewController.h"
#import "FJLinkGroup.h"
#import "FJLinkFriends.h"
#import "FJLoadPlist.h"
#import "FJBaseTableView.h"
#import "Masonry.h"

#define ID @"customCell"

@interface FJLinkManTableViewController ()
@property (nonatomic,weak) FJBaseTableView *tvVc;

@property (nonatomic,assign) CGFloat height;

@end

@implementation FJLinkManTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(pushToAdd)];
    
    FJBaseTableView *baseTableViewVc = [[FJBaseTableView alloc]initWithPlistName:@"linkfriend.plist"];
    [self addChildViewController:baseTableViewVc];
    baseTableViewVc.tableView.bounds = self.view.frame;
    [self.view addSubview:baseTableViewVc.tableView];
}

- (void)pushToAdd
{
    NSLog(@"xxxx");
}

@end
