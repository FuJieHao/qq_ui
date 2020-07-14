//
//  FJLoadPlist.h
//  九宫格视图
//
//  Created by Mac on 16/8/3.
//  Copyright © 2016年 haofujie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FJLoadPlist : NSObject

+ (NSArray *)loadPlist:(NSString *)plistName loadModel:(Class)model;

@end
