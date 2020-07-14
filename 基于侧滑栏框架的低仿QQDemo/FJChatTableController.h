//
//  FJChatTableController.h
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/26.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJMessageModel,FJChatTableController;
@protocol FJChatTableControllerDelegate <NSObject>

- (void)ChatTableController:(FJChatTableController *)chatController andLastText:(FJMessageModel *)currentModel;

@end

@interface FJChatTableController : UIViewController

@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) FJMessageModel *model;

@property (nonatomic,weak) id<FJChatTableControllerDelegate> delegate;

@end
