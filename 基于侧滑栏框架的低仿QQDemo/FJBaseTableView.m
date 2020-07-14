//
//  FJBaseTableView.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJBaseTableView.h"
#import "FJLinkGroup.h"
#import "FJLinkFriends.h"
#import "FJLoadPlist.h"
#import "FJBaseHeaderView.h"
#import "FJBaseLinkCell.h"

#define ID @"损友"

@interface FJBaseTableView () <FJBaseHeaderViewDelegate>

@end

@implementation FJBaseTableView
{
    NSArray *_model;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 1) {
        return 20;
    } else if (section == 5){
        return 20;
    }
    return 0.1f;
}

- (void)groupHeaderViewDidClickTitleButton:(FJBaseLinkCell *)groupHeaderView
{
    //局部刷新
    //创建一个用来表示某个组的对象
    NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:groupHeaderView.tag];
    [self.tableView reloadSections:idxSet withRowAnimation:UITableViewRowAnimationNone];
}

- (instancetype)initWithPlistName:(NSString *)plistName
{
    if (self = [super init]){
        NSArray *array = [FJLoadPlist loadPlist:plistName
                                      loadModel:[FJLinkGroup class]];
        _model = array;
        
        [self.tableView registerClass:[FJBaseLinkCell class] forCellReuseIdentifier:ID];
        self.tableView.sectionHeaderHeight = 45;
        
        //预估行高
        self.tableView.estimatedRowHeight = 80;
        //自动计算行高
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
    }
    return self;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return _model.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //在这个方法中，要根据当前组的状态(是否展开），来设置不同的返回值
    //所以，要为fjgroup增加一个属性：是否展开
    FJLinkGroup *group = _model[section];
    if (group.isVisible) {
        return group.friends.count;
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //1.获取模型对象(数据）
    FJLinkGroup *group = _model[indexPath.section];
    FJLinkFriends *friend = group.friends[indexPath.row];
    FJBaseLinkCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    cell.friendsModel = friend;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    FJLinkGroup *group = _model[section];
    FJBaseHeaderView *headerView = [FJBaseHeaderView groupHeaderViewWithTableView:tableView];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5)];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.5f;
    [headerView.contentView addSubview:line];
    
    headerView.tag = section;
    
    headerView.groupModel = group;
    
    headerView.delegate = self;
    
    //在这里创建好的header view中获取的header view的frame都是0，因为刚刚创建好的header view没有对其进行赋值,所以frame都是0
    //但是，程序运行以后，可以看到header view，是因为在这里将其返回后，在执行的时候，会用到header view，就将header view添加到uitableView中，当吧header view添加到uitableView中的时候，uitableView会根据一些设置来给其赋值，（动态为其赋值）
    
    return headerView;
}


@end
