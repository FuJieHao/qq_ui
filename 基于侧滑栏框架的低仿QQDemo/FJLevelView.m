//
//  FJLevelView.m
//  口碑的破界面
//
//  Created by Mac on 16/8/11.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJLevelView.h"

#define Height self.bounds.size.height

@implementation FJLevelView

- (instancetype)init
{
    if (self = [super init]) {
//        self.levelNumber = 50.0;
    }
    return self;
}

- (void)setLevelNumber:(CGFloat)levelNumber
{
    _levelNumber = levelNumber;
    NSInteger roundNum = (NSInteger)levelNumber;
    
    NSInteger taiYang = roundNum / 16;
    
    if (taiYang > 0) {
        for (NSInteger i = 0; i < taiYang; i++) {
            [self foundLevelImage:@"usersummary_icon_lv_sun" andIndex:i];
        }
    }
    
    NSInteger yueliang = (roundNum - 16 * taiYang) / 4;
    if (yueliang > 0) {
        for (NSInteger i = taiYang; i < yueliang + taiYang; i++) {
            [self foundLevelImage:@"usersummary_icon_lv_moon"andIndex:i];
        }
    }
    
    NSInteger xingxing = roundNum - 16 * taiYang - 4 * yueliang;
    if (xingxing > 0) {
        for (NSInteger i = taiYang + yueliang; i < xingxing + yueliang + taiYang; i++) {
            [self foundLevelImage:@"usersummary_icon_lv_star" andIndex:i];
        }
    }
}

- (void)foundLevelImage:(NSString *)imageName andIndex:(NSInteger)index
{
    UIImageView *levelImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
    CGRect imageRect = CGRectMake(0, 0, 16, 16);
    levelImage.frame = CGRectOffset(imageRect, index * 16, 0);
    [self addSubview:levelImage];
}

@end
