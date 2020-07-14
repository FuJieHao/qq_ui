//
//  FJLeftSortViewController.m
//  侧滑栏封装
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJLeftSortViewController.h"
#import "FJSiderView.h"
#import "UIImage+FJImage.h"
#import "FJSiderBottomView.h"

@interface FJLeftSortViewController () <UITableViewDataSource,UITableViewDelegate>

@end

static NSString *Identifier = @"Identifier";
@implementation FJLeftSortViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:0/255.0 green:183/255.0 blue:249/255.0 alpha:1];
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidebar_bg"]];
    backImage.frame = CGRectMake(0, 0, self.view.frame.size.width, 290);
    [self.view addSubview:backImage];
    
    FJSiderView *view = [[FJSiderView alloc]initWithFrame:CGRectMake(70, 45, self.view.frame.size.width - 120, 100)];
    view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:view];
    
    FJSiderBottomView *bottomView = [[FJSiderBottomView alloc]initWithFrame:CGRectMake(70, self.view.frame.size.height - 70, self.view.frame.size.width - 240, 70)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    [self setUpTableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:Identifier];
}

- (void)setUpTableView
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:tableView];
    
    self.tableView.rowHeight = 50;
    
    self.tableView = tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier forIndexPath:indexPath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_vip"];
        cell.textLabel.text = @"开通会员";
    } else if (indexPath.row == 1) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_purse"];
        cell.textLabel.text = @"QQ钱包";
    } else if (indexPath.row == 2) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_business"];
        cell.textLabel.text = @"网上营业厅";
    } else if (indexPath.row == 3) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_decoration"];
        cell.textLabel.text = @"个性装扮";
    } else if (indexPath.row == 4) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_favorit"];
        cell.textLabel.text = @"我的收藏";
    } else if (indexPath.row == 5) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_album"];
        cell.textLabel.text = @"我的相册";
    } else if (indexPath.row == 6) {
        cell.imageView.image = [UIImage imageNamed:@"sidebar_file"];
        cell.textLabel.text = @"我的文件";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end



