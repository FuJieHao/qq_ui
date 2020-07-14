//
//  FJBaseHeaderView.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJBaseHeaderView;
@protocol FJBaseHeaderViewDelegate <NSObject>

- (void)groupHeaderViewDidClickTitleButton:(FJBaseHeaderView *)groupHeaderView;

@end

@class FJLinkGroup;
@interface FJBaseHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) FJLinkGroup *groupModel;

@property (nonatomic,weak) id<FJBaseHeaderViewDelegate>delegate;

+ (instancetype)groupHeaderViewWithTableView:(UITableView *)tableView;

@end
