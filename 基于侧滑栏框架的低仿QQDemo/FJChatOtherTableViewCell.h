//
//  FJChatOtherTableViewCell.h
//  zfb
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJChatModel;
@interface FJChatOtherTableViewCell : UITableViewCell

@property (nonatomic,strong) FJChatModel *model;
@property (nonatomic,copy) NSString *otherIconName;

@end
