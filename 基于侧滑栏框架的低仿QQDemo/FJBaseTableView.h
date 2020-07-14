//
//  FJBaseTableView.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJBaseTableView;
@protocol FJBaseTableViewDelegate <NSObject>

- (CGFloat)baseTableView:(FJBaseTableView *)tableView andTableViewHeight:(CGFloat)tableViewHeight;

@end

@interface FJBaseTableView : UITableViewController

- (instancetype)initWithPlistName:(NSString *)plistName;
@property (nonatomic,weak) id<FJBaseTableViewDelegate> delegate;

@end
