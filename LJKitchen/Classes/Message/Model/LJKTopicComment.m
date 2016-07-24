//
//  LJKTopicComment.m
//  LJKitchen
//
//  Created by  a on 16/6/24.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKTopicComment.h"

@implementation LJKTopicComment


- (CGFloat)cellHeight {
    CGFloat W = SCREEN_WIDTH - LJKAuthorIconWH - LJKAuthorIcon2CellLeft * 3;
    CGFloat textH = [self.txt getSizeWithEstimatedSize:CGSizeMake(W, MAXFLOAT) font:15].height;
    _cellHeight = textH + LJKAuthorIconWH * 0.5 + 2 * LJKAuthorIcon2CellTop;
    
    return _cellHeight;
}

- (NSString *)create_time {
    // 转换为需要的时间格式
    _create_time = [NSString timeToRequiredStyleWithText:_create_time];
    return _create_time;
}

@end
