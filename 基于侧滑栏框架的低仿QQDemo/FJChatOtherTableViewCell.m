//
//  FJChatOtherTableViewCell.m
//  zfb
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJChatOtherTableViewCell.h"
#import "FJChatModel.h"
#import "UILabel+FJLabelCategory.h"
#import "Masonry.h"

@interface FJChatOtherTableViewCell ()

@property (nonatomic,weak) UILabel *contentLabel;
@property (nonatomic,weak) UILabel *timeLabel;

@property (nonatomic,weak) UIImageView *imageViews;

@end

@implementation FJChatOtherTableViewCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];
        [self setUpUI];
    }
    return self;
}

- (void)setModel:(FJChatModel *)model
{
    _model = model;
    self.contentLabel.text = model.text;
    self.timeLabel.text = model.time;
}

- (void)setOtherIconName:(NSString *)otherIconName
{
    _otherIconName = otherIconName;
    self.imageViews.image = [UIImage imageNamed:_otherIconName];
}

- (void)setUpUI
{
    
    UILabel *timeLabel = [UILabel labelQuicklyFoundLabel:@"昨天10:30" andFont:10 andColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiangxue"]];
    iconImage.layer.cornerRadius = 44 * 0.5;
    iconImage.layer.masksToBounds = YES;
    self.imageViews = iconImage;
    [self.contentView addSubview:iconImage];
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Dialog_white.left"]];
    [self.contentView addSubview:backImage];
    
    UILabel *contentLabel = [UILabel labelQuicklyFoundLabel:@"xxxxxxxxxxx" andFont:14 andColor:[UIColor darkGrayColor]];
    contentLabel.numberOfLines = 0;
    [self.contentView addSubview:contentLabel];
    self.contentLabel = contentLabel;
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.centerX.equalTo(self.contentView);
    }];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(8);
        make.top.equalTo(timeLabel.mas_bottom).offset(8);
        make.width.height.offset(44);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).offset(16);
        make.width.lessThanOrEqualTo(@200);
    }];
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImage);
        make.top.left.right.bottom.equalTo(contentLabel).mas_equalTo(UIEdgeInsetsMake(-8, -14, -8, -8));
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.bottom.greaterThanOrEqualTo(backImage.mas_bottom).offset(3);
        make.bottom.greaterThanOrEqualTo(iconImage.mas_bottom).offset(3);
    }];
}


@end
