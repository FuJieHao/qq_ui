//
//  FJLoadPlist.m
//  九宫格视图
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import "FJLoadPlist.h"
#import "FJMessageModel.h"
#import "FJLinkGroup.h"

@implementation FJLoadPlist

+ (NSArray *)loadPlist:(NSString *)plistName loadModel:(Class)model
{
    NSMutableArray *arrM = [NSMutableArray array];
    
    NSString *path = [[NSBundle mainBundle]pathForResource:plistName ofType:nil];
    
    NSArray *arr = [NSArray arrayWithContentsOfFile:path];
    
    for (NSDictionary *dict in arr) {
        
        id models = [[model alloc]initWithDict:dict];
        [arrM addObject:models];
    }
    return arrM;
}

@end
