//
//  FJMessageTableViewController.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJMessageTableViewController.h"
#import "FJMessageTableViewCell.h"
#import "FJLoadPlist.h"
#import "FJMessageModel.h"
#import "FJChatTableController.h"
#import "FTPopOverMenu.h"

#define ID @"消息"

@interface FJMessageTableViewController () <FJChatTableControllerDelegate>

@property (nonatomic,strong) FJMessageTableViewCell *cell;

@property (nonatomic,assign) BOOL isMenueBtnClick;

@end

@implementation FJMessageTableViewController
{
    NSArray *_model;
}

- (void)ChatTableController:(FJChatTableController *)chatController andLastText:(FJMessageModel *)currentModel
{
//    [self.tableView reloadData];
    
    //还是用局部刷新，效果比较好。
    NSInteger row = [_model indexOfObject:currentModel];
    NSIndexPath *refreshIndex = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView reloadRowsAtIndexPaths:@[refreshIndex] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger selectedRow = self.tableView.indexPathForSelectedRow.row;
    FJChatTableController *chatVc = [[FJChatTableController alloc]init];
    chatVc.delegate = self;
    FJMessageModel *model = _model[selectedRow];
    chatVc.model = model;
    chatVc.title = model.name;
    chatVc.tableView.backgroundColor = [UIColor whiteColor];
    chatVc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:chatVc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _model.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FJMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    FJMessageModel *model = _model[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)menueClick:(UIButton *)sender
{
    if (!self.isMenueBtnClick) {
        UIView *blackView = [[UIView alloc]initWithFrame:self.tableView.bounds];
        blackView.backgroundColor = [UIColor blackColor];
        blackView.alpha = 0;
        [self.tableView addSubview:blackView];
        [UIView animateWithDuration:0.3 animations:^{
            blackView.alpha = 0.5;
        }];
    }
    
    [FTPopOverMenu setTintColor:[UIColor whiteColor]];
    [FTPopOverMenu setTextColor:[UIColor blackColor]];

    [FTPopOverMenu showForSender:sender withMenu:@[@"多人聊天",
                                                   @"加好友",
                                                   @"扫一扫",
                                                   @"面对面快传",
                                                   @"付款"]
                  imageNameArray:@[@"menu_icon_chat",
                                   @"menu_icon_c2c_shortcut",
                                   @"menu_icon_QR",
                                   @"menu_icon_camera",
                                   @"buddy_header_icon_addressBook",]
                       doneBlock:^(NSInteger selectedIndex) {
                           [self deleteBlackView];
            } dismissBlock:^{
                [self deleteBlackView];
    }];
}

- (void)deleteBlackView
{
    for (UIView *view in self.tableView.subviews) {
        if (view.alpha == 0.5) {
            [UIView animateWithDuration:0.3 animations:^{
                view.alpha = 0;
            } completion:^(BOOL finished) {
                [view removeFromSuperview];
            }];
        }
    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [FJLoadPlist loadPlist:@"friendlist.plist" loadModel:[FJMessageModel class]];
    _model = array;
    
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"消息",@"电话"]];
    segmentControl.tintColor = [UIColor whiteColor];
    segmentControl.selectedSegmentIndex = 0;
    
    self.navigationItem.titleView = segmentControl;
    
    UIButton *rightBar = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBar.frame = CGRectMake(0, 0, 32, 32);
    rightBar.userInteractionEnabled = YES;
    [rightBar setBackgroundImage:[UIImage imageNamed:@"Snip20160820_2"] forState:UIControlStateNormal];
    [rightBar addTarget:self action:@selector(menueClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBar];
    
    [self.tableView registerClass:[FJMessageTableViewCell class] forCellReuseIdentifier:ID];
    
    //预估行高
    self.tableView.estimatedRowHeight = 100;
    //自动计算行高
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

@end
