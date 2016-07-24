//
//  LJKTopic.m
//  LJKitchen
//
//  Created by  a on 16/6/23.
//  Copyright © 2016年 ycdsq. All rights reserved.
//

#import "LJKTopic.h"
#import "LJKAuthor.h"

@implementation LJKTopic

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

- (CGFloat)cellHeight {
    CGFloat contentH = [self detailHeaderHeight];
    if (contentH > 20 || self.is_sticked) {
        _cellHeight = 110;
    } else {
        _cellHeight = 90;
    }
    return _cellHeight;
}

- (CGFloat)detailHeaderHeight {
    CGFloat contentH = [self contentHeight];
    CGFloat sumH = contentH + LJKAuthorIconWH + LJKAuthorIcon2CellTop * 2 + 10;
    
    return sumH;
}


- (CGFloat)contentHeight {
    CGFloat W = SCREEN_WIDTH - LJKAuthorIconWH - LJKAuthorIcon2CellLeft * 2 - 10;
    CGFloat contentH = [self.content getSizeWithEstimatedSize:CGSizeMake(W, MAXFLOAT) font:15].height;
    return contentH;
}

- (NSString *)latest_comment_time {
    return  [NSString timeToRequiredStyleWithText:_latest_comment_time];
}

@end
