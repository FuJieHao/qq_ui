//
//  FJSiderBottomView.m
//  基于侧滑栏框架的低仿QQDemo
//
//  Created by Mac on 16/8/25.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJSiderBottomView.h"
#import "Masonry.h"

@implementation FJSiderBottomView

//设置，夜间
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        
    }
    return self;
}

- (void)setupUI
{
    UIButton *setBtn = [[UIButton alloc]init];
    [setBtn setImage:[UIImage imageNamed:@"sidebar_setting"] forState:UIControlStateNormal];
    [setBtn setTitle:@" 设置" forState:UIControlStateNormal];
    [setBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:setBtn];
    
    UIButton *nightBtn = [[UIButton alloc]init];
    [nightBtn setImage:[UIImage imageNamed:@"sidebar_nightmode_on"] forState:UIControlStateNormal];
    [nightBtn setTitle:@" 夜间" forState:UIControlStateNormal];
    [nightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:nightBtn];
    
    [setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-8);
        make.left.equalTo(self.mas_centerX).offset(-50);
        make.width.equalTo(@80);
        make.height.equalTo(@45);
    }];
    [nightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-8);
        make.left.equalTo(self.mas_centerX).offset(50);
        make.width.equalTo(@80);
        make.height.equalTo(@45);
    }];
}

@end
