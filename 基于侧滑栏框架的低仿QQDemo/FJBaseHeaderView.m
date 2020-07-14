//
//  FJBaseHeaderView.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJBaseHeaderView.h"
#import "FJLinkGroup.h"

@interface  FJBaseHeaderView ()

@property (nonatomic,weak) UIButton *btnGroupName;
@property (nonatomic,weak) UILabel *onlineCount;

@end

@implementation FJBaseHeaderView

+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView
{
    //2.创建UITableViewHeaderFooterView
    static NSString *ID = @"group_header_view";
    
    FJBaseHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (headerView == nil) {
        headerView = [[FJBaseHeaderView alloc]initWithReuseIdentifier:ID];
    }
    return headerView;
}

- (void)setGroupModel:(FJLinkGroup *)groupModel
{
    _groupModel = groupModel;
    
    [self.btnGroupName setTitle:[NSString stringWithFormat:@"  %@",groupModel.name] forState:UIControlStateNormal];
    //设置lable上的文字
    self.onlineCount.text = [NSString stringWithFormat:@"%ld/%lu",(long)groupModel.online,(unsigned long)groupModel.friends.count];
    self.onlineCount.textColor = [UIColor darkGrayColor];
    self.onlineCount.font = [UIFont systemFontOfSize:13];
    if (self.groupModel.isVisible) {
        //让按钮中的图片实现旋转
        self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        //让按钮中的图片回到原来位置
        self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIButton *btnGroupTitle = [[UIButton alloc]init];
    [btnGroupTitle setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
    [btnGroupTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [btnGroupTitle setBackgroundColor:[UIColor whiteColor]];
    btnGroupTitle.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //内边距
    btnGroupTitle.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    //设置按钮表题距离左边的边距
    btnGroupTitle.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    
    [btnGroupTitle addTarget:self action:@selector(btnGroupTitleClick) forControlEvents:UIControlEventTouchUpInside];
    
    btnGroupTitle.imageView.contentMode = UIViewContentModeCenter;
    //设置图片框超出的部分不要截掉
    btnGroupTitle.imageView.clipsToBounds = NO;
    
    [self.contentView addSubview:btnGroupTitle];
    self.btnGroupName = btnGroupTitle;
    
    //创建lable
    UILabel *lblCount = [[UILabel alloc]init];
    [self.contentView addSubview:lblCount];
    self.onlineCount = lblCount;
}

//组标题按钮的点击事件
- (void)btnGroupTitleClick
{
    //1.设置组的状态(把组的状态改为原来的相反状态）
    self.groupModel.visible = !self.groupModel.isVisible;
    //2.headerview想刷新uitableview，所以要找代理
    //刷新tableView
    if ([self.delegate respondsToSelector:@selector(groupHeaderViewDidClickTitleButton:)]) {
        //调用代理方法
        [self.delegate groupHeaderViewDidClickTitleButton:self];
    }
}

//当一个新的headerVie（已经加到）某个父控件后执行这个方法
- (void)didMoveToSuperview
{
    if (self.groupModel.isVisible) {
        //让按钮中的图片实现旋转
        self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        //让按钮中的图片回到原来位置
        self.btnGroupName.imageView.transform = CGAffineTransformMakeRotation(0);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //设置frame
    self.btnGroupName.frame = self.bounds;
    
    CGFloat lblW = 50;
    CGFloat lblH = self.bounds.size.height;
    CGFloat lblX = self.bounds.size.width - lblW;
    CGFloat lblY = 0;
    self.onlineCount.frame = CGRectMake(lblX, lblY, lblW, lblH);
}


@end
