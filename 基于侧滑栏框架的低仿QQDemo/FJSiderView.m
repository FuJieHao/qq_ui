//
//  FJSiderView.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/20.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSiderView.h"
#import "UILabel+FJLabelCategory.h"
#import "Masonry.h"
#import "FJLevelView.h"

@implementation FJSiderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    UIView *whiteView = [[UIView alloc]init];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.layer.cornerRadius = 50 * 0.5;
    whiteView.layer.masksToBounds = YES;
    [self addSubview:whiteView];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"me"]];
    imageView.layer.cornerRadius = 47 * 0.5;
    imageView.layer.masksToBounds = YES;
    [whiteView addSubview:imageView];
    
    UIImageView *signa = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidebar_signature_other"]];
    [self addSubview:signa];
    UIImageView *signature = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sidebar_signature_nor"]];
    [signa addSubview:signature];
    
    UILabel *nameLabel = [UILabel labelQuicklyFoundLabel:@"甲基苯丙胺" andFont:17 andColor:[UIColor blackColor]];
    [self addSubview:nameLabel];
    
    FJLevelView *leverlView = [[FJLevelView alloc]init];
    leverlView.backgroundColor = [UIColor clearColor];
    leverlView.levelNumber = 50;
    [self addSubview:leverlView];
    
    UILabel *signLabel = [UILabel labelQuicklyFoundLabel:@"社会败类一枚。" andFont:14 andColor:[UIColor darkGrayColor]];
    [self addSubview:signLabel];
    
    UIButton *erWeiMa = [[UIButton alloc]init];
    [erWeiMa setImage:[UIImage imageNamed:@"sidebar_ QRcode_normal"] forState:UIControlStateNormal];
    [erWeiMa setImage:[UIImage imageNamed:@"sidebar_ QRcode_press"] forState:UIControlStateHighlighted];
    [self addSubview:erWeiMa];
    
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.offset(20);
        make.height.width.equalTo(@50);
    }];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.offset(0);
        make.height.width.equalTo(@47);
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_right).offset(8);
        make.top.equalTo(whiteView.mas_top);
    }];
    [leverlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameLabel);
        make.top.equalTo(nameLabel.mas_bottom).offset(8);
        make.height.equalTo(@16);
        make.width.equalTo(@100);
    }];
    [signa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteView.mas_left);
        make.top.equalTo(whiteView.mas_bottom).offset(12);
    }];
    [signature mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(signa);
        make.width.height.equalTo(signa);
    }];
    [signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(signature);
        make.left.equalTo(signature.mas_right).offset(2);
    }];
    [erWeiMa mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.top.equalTo(whiteView.mas_top).offset(4);
        make.width.height.equalTo(@25);
    }];
}

@end
