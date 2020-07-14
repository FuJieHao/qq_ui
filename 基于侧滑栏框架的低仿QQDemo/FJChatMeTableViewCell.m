//
//  FJChatMeTableViewCell.m
//  zfb
//
//  Created by Mac on 16/8/18.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJChatMeTableViewCell.h"
#import "FJChatModel.h"
#import "UILabel+FJLabelCategory.h"
#import "Masonry.h"

@interface FJChatMeTableViewCell ()

@property (nonatomic,weak) UILabel *contentLabel;
@property (nonatomic,weak) UILabel *timeLabel;

@end

@implementation FJChatMeTableViewCell

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

- (void)setUpUI
{
    UILabel *timeLabel = [UILabel labelQuicklyFoundLabel:@"昨天10:30" andFont:10 andColor:[UIColor lightGrayColor]];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me"]];
    
    iconImage.layer.cornerRadius = 44 * 0.5;
    iconImage.layer.masksToBounds = YES;
    
    [self.contentView addSubview:iconImage];
    
    UIImageView *backImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Dialog_green.right"]];
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
        make.right.offset(-8);
        make.top.equalTo(timeLabel.mas_bottom).offset(8);
        make.width.height.offset(44);
    }];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(iconImage.mas_left).offset(-16);
        make.width.lessThanOrEqualTo(@200);
    }];
    
    [backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImage);
        make.top.left.right.bottom.equalTo(contentLabel).mas_equalTo(UIEdgeInsetsMake(-8, -8, -8, -14));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
        make.bottom.greaterThanOrEqualTo(backImage.mas_bottom).offset(3);
        make.bottom.greaterThanOrEqualTo(iconImage.mas_bottom).offset(3);
    }];
}

@end
