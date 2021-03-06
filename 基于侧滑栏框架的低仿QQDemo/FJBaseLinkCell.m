//
//  FJBaseLinkCell.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/27.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJBaseLinkCell.h"
#import "FJLinkFriends.h"
#import "UILabel+FJLabelCategory.h"
#import "Masonry.h"

@interface FJBaseLinkCell ()

@property (nonatomic,weak) UIImageView *iconImage;
@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *subTitleLabel;
@property (nonatomic,weak) UILabel *timeLabel;
@property (nonatomic,weak) UILabel *noReadNumberLabel;

@end

@implementation FJBaseLinkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setFriendsModel:(FJLinkFriends *)friendsModel
{
    _friendsModel = friendsModel;
    
    self.iconImage.image = [UIImage imageNamed:friendsModel.icon];
    self.nameLabel.text = friendsModel.name;
    self.subTitleLabel.text = friendsModel.intro;
    self.timeLabel.text = friendsModel.status;
}

- (void)setUpUI
{
    CGFloat imageW = 50;
    
    UIImageView *image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"973383239DCF6652FBD7C2E33587BBDFE9AF19238"]];
    image.layer.cornerRadius = imageW * 0.5;
    image.layer.masksToBounds = YES;
    
    [self.contentView addSubview:image];
    self.iconImage = image;
    
    UILabel *nameLabel = [UILabel labelQuicklyFoundLabel:@"小月月" andFont:18 andColor:[UIColor blackColor]];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *subTitleLabel = [UILabel labelQuicklyFoundLabel:@"富杰哥哥~" andFont:15 andColor:[UIColor grayColor]];
    [self.contentView addSubview:subTitleLabel];
    self.subTitleLabel = subTitleLabel;
    
    UILabel *timeLabel = [UILabel labelQuicklyFoundLabel:@"20:10" andFont:15 andColor:[UIColor darkGrayColor]];
    [self.contentView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.left.offset(12);
        make.width.height.equalTo(@(imageW));
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image.mas_top);
        make.left.equalTo(image.mas_right).offset(8);
        
    }];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.right.offset(-20);
        make.top.equalTo(nameLabel.mas_bottom).offset(10);
    }];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(8);
        make.right.offset(-8);
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.top.offset(0);
        make.bottom.equalTo(image.mas_bottom).offset(8);
    }];
}


@end
